# Load WPF and Windows Forms assemblies
Add-Type -AssemblyName PresentationFramework, System.Windows.Forms

# XAML
$XAML = @"
<Window xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
        Title="SetupBuddy" Height="600" Width="800"
        Background="#111111" AllowsTransparency="True" WindowStyle="None">

    <Window.Resources>
        <!-- Button style for neon look, including disabled state -->
        <Style TargetType="Button">
            <Setter Property="Background" Value="#111111"/>
            <Setter Property="Foreground" Value="White"/>
            <Setter Property="BorderBrush" Value="#FF00AA"/>
            <Setter Property="BorderThickness" Value="2"/>
            <Setter Property="Padding" Value="10,5"/>
            <Style.Triggers>
                <Trigger Property="IsEnabled" Value="False">
                    <Setter Property="Foreground" Value="#FF00AA"/>
                    <Setter Property="BorderBrush" Value="#FF00AA"/>
                    <Setter Property="Background" Value="#111111"/>
                    <Setter Property="Opacity" Value="0.5"/>
                </Trigger>
            </Style.Triggers>
        </Style>

        <!-- TextBlock style for neon headers -->
        <Style TargetType="TextBlock" x:Key="NeonHeader">
            <Setter Property="Foreground" Value="White"/>
            <Setter Property="FontWeight" Value="Bold"/>
            <Setter Property="Effect">
                <Setter.Value>
                    <DropShadowEffect Color="#FF00AA" BlurRadius="15" ShadowDepth="0" Opacity="0.8"/>
                </Setter.Value>
            </Setter>
        </Style>
    </Window.Resources>

    <!-- Outer neon border -->
    <Border BorderBrush="#FF00AA" BorderThickness="3" CornerRadius="12" Background="#111111" Padding="0">
        <Border.Effect>
            <DropShadowEffect Color="#FF00AA" BlurRadius="25" ShadowDepth="0" Opacity="0.9"/>
        </Border.Effect>

        <Grid>
            <!-- Custom top bar -->
            <Border x:Name="TopBar" Background="#111111" Height="30" VerticalAlignment="Top">
                <DockPanel LastChildFill="True">
                    <TextBlock Text="SetupBuddy" Foreground="White" VerticalAlignment="Center" Margin="10,0" FontWeight="Bold">
                        <TextBlock.Effect>
                            <DropShadowEffect Color="#FF00AA" BlurRadius="10" ShadowDepth="0" Opacity="0.9"/>
                        </TextBlock.Effect>
                    </TextBlock>
                    <StackPanel Orientation="Horizontal" HorizontalAlignment="Right">
                        <Button x:Name="MinimizeButton" Content="_" Width="30" Height="30"/>
                        <Button x:Name="MaximizeButton" Content="☐" Width="30" Height="30"/>
                        <Button x:Name="CloseButton" Content="X" Width="30" Height="30" Foreground="Red"/>
                    </StackPanel>
                </DockPanel>
            </Border>

            <!-- Main content area -->
            <Grid Margin="15,35,15,15">
                <Grid.RowDefinitions>
                    <RowDefinition Height="Auto"/>
                    <RowDefinition Height="Auto"/>
                    <RowDefinition Height="Auto"/>
                    <RowDefinition Height="Auto"/>
                    <RowDefinition Height="Auto"/>
                    <RowDefinition Height="Auto"/>
                    <RowDefinition Height="*"/>
                    <RowDefinition Height="Auto"/>
                </Grid.RowDefinitions>

                <!-- Headers -->
                <TextBlock Grid.Row="0" Text="Welcome to SetupBuddy - a JexiDev creation!" FontSize="20" HorizontalAlignment="Center" Margin="0,0,0,5" Style="{StaticResource NeonHeader}"/>
                <TextBlock Grid.Row="1" Text="Taking you from chaos to install in a matter of clicks." HorizontalAlignment="Center" Margin="0,0,0,10" Foreground="White"/>

                <!-- Step 1 -->
                <TextBlock Grid.Row="2" Text="Step 1: Make sure all .rar/part files for your downloaded game are in the same folder." Margin="0,0,0,5" Foreground="White"/>
                <StackPanel Grid.Row="3" Orientation="Horizontal" Margin="0,0,0,10">
                    <Label Content="Game Folder Path:" VerticalAlignment="Center" Width="120" Foreground="White"/>
                    <TextBox x:Name="TargetPathTextBox" Width="400" VerticalAlignment="Center" Background="#222222" Foreground="White" BorderBrush="#FF00AA"/>
                    <Button x:Name="ConfirmPathButton" Content="Confirm" Margin="5,0,0,0"/>
                    <Button x:Name="BrowseButton" Content="Browse..." Margin="5,0,0,0"/>
                </StackPanel>

                <!-- Step 2 -->
                <TextBlock Grid.Row="4" Text="Step 2: Find or download 7-Zip." Margin="0,0,0,5" Foreground="White"/>
                <StackPanel Grid.Row="5" Orientation="Horizontal" Margin="0,0,0,10">
                    <Label Content="7-Zip Path:" VerticalAlignment="Center" Width="120" Foreground="White"/>
                    <TextBox x:Name="SevenZipPathTextBox" Width="400" VerticalAlignment="Center" Background="#222222" Foreground="White" BorderBrush="#FF00AA"/>
                    <Button x:Name="Find7ZipButton" Content="Find 7-Zip" Margin="5,0,0,0"/>
                    <Button x:Name="Download7ZipButton" Content="Download 7-Zip" Margin="5,0,0,0"/>
                </StackPanel>

                <!-- Status Box -->
                <Border Grid.Row="6" BorderBrush="#FF00AA" BorderThickness="1" CornerRadius="5" Padding="10">
                    <ScrollViewer x:Name="StatusScrollViewer">
                        <TextBlock x:Name="StatusTextBlock" TextWrapping="Wrap" VerticalAlignment="Top" HorizontalAlignment="Left" Margin="0,0,0,5" Foreground="White"/>
                    </ScrollViewer>
                </Border>

                <!-- Action Buttons -->
                <StackPanel Grid.Row="7" Orientation="Horizontal" HorizontalAlignment="Center" Margin="0,15,0,0">
                    <Button x:Name="ExtractButton" Content="Start Extraction" Margin="0,0,10,0"/>
                    <Button x:Name="LaunchSetupButton" Content="Launch Setup.exe" IsEnabled="False"/>
                </StackPanel>

            </Grid>
        </Grid>
    </Border>
</Window>
"@

# Load the XAML
try {
    $xmlDoc = [System.Xml.XmlDocument]::new()
    $xmlDoc.LoadXml($xaml)
    $reader = [System.Xml.XmlNodeReader]::new($xmlDoc)
    $window = [Windows.Markup.XamlReader]::Load($reader)
}
catch {
    Write-Host "Error loading XAML:`n$_"
    exit
}

# Strip Windows-Style Border
$window.WindowStyle = 'None'
$window.AllowsTransparency = $true
$window.Background = [System.Windows.Media.Brushes]::Black

$TopBar = $window.FindName("TopBar")
$MinimizeButton = $window.FindName("MinimizeButton")
$MaximizeButton = $window.FindName("MaximizeButton")
$CloseButton = $window.FindName("CloseButton")

Write-Host "TopBar is null? $($null -eq $TopBar)"
Write-Host "MinimizeButton is null? $($null -eq $MinimizeButton)"
Write-Host "MaximizeButton is null? $($null -eq $MaximizeButton)"
Write-Host "CloseButton is null? $($null -eq $CloseButton)"

# Find UI elements
$TargetPathTextBox = $window.FindName("TargetPathTextBox")
$BrowseButton = $window.FindName("BrowseButton")
$ConfirmPathButton = $window.FindName("ConfirmPathButton")
$SevenZipPathTextBox = $window.FindName("SevenZipPathTextBox")
$Find7ZipButton = $window.FindName("Find7ZipButton")
$Download7ZipButton = $window.FindName("Download7ZipButton")
$StatusTextBlock = $window.FindName("StatusTextBlock")
$StatusScrollViewer = $window.FindName("StatusScrollViewer")
$ExtractButton = $window.FindName("ExtractButton")
$LaunchSetupButton = $window.FindName("LaunchSetupButton")

# Make the top bar draggable
$TopBar.Add_MouseLeftButtonDown({
    $window.DragMove()
})

# Hook up window control buttons
$MinimizeButton.Add_Click({
    $window.WindowState = 'Minimized'
})

$MaximizeButton.Add_Click({
    if ($window.WindowState -eq 'Normal') {
        $window.WindowState = 'Maximized'
    } else {
        $window.WindowState = 'Normal'
    }
})

$CloseButton.Add_Click({
    $window.Close()
})

# Neon hover effect for top bar buttons
$HoverBrush = [System.Windows.Media.Brushes]::HotPink
$DefaultBrush = [System.Windows.Media.Brushes]::White

foreach ($btn in @($MinimizeButton, $MaximizeButton)) {
    $btn.Add_MouseEnter({ $btn.Foreground = $HoverBrush })
    $btn.Add_MouseLeave({ $btn.Foreground = $DefaultBrush })
}
$CloseButton.Add_MouseEnter({ $CloseButton.Foreground = [System.Windows.Media.Brushes]::Red })
$CloseButton.Add_MouseLeave({ $CloseButton.Foreground = [System.Windows.Media.Brushes]::Red })


# Global variables for threading
$global:outputQueue = [System.Collections.Concurrent.ConcurrentQueue[string]]::new()
$global:timer = $null
$global:extractionJob = $null

# Functions
function Write-Status {
    param([string]$text)
    # This ensures the UI update is on the correct thread.
    $window.Dispatcher.Invoke([Action[string]] { 
            param($t) 
            $StatusTextBlock.Text += "`n$t"
            $StatusScrollViewer.ScrollToBottom()
        }, $text)
}

function Get-7ZipPathGUI {
    $defaultPaths = @(
        "$PSScriptRoot\Tools\7z.exe",
        "$env:ProgramFiles\7-Zip\7z.exe",
        "$env:ProgramFiles(x86)\7-Zip\7z.exe",
        "D:\Program Files\7-Zip\7z.exe",
        "D:\Program Files (x86)\7-Zip\7z.exe"
    )
    foreach ($path in $defaultPaths) {
        if (Test-Path $path) { return $path }
    }
    return $null
}

# Event Handlers
$BrowseButton.Add_Click({
        $folderBrowser = New-Object System.Windows.Forms.FolderBrowserDialog
        $folderBrowser.Description = "Select your game's setup folder."
        if ($folderBrowser.ShowDialog() -eq [System.Windows.Forms.DialogResult]::OK) {
            $TargetPathTextBox.Text = $folderBrowser.SelectedPath
            Write-Status "Folder selected: $($folderBrowser.SelectedPath)"
        }
    })

$ConfirmPathButton.Add_Click({
        $path = $TargetPathTextBox.Text
        if (Test-Path $path) {
            Write-Status "Confirmed folder path: $path"
        }
        else {
            Write-Status "Warning: '$path' does not exist. Please check the folder path."
        }
    })

$Find7ZipButton.Add_Click({
        $sevenZipPath = Get-7ZipPathGUI
        if ($sevenZipPath) {
            $SevenZipPathTextBox.Text = $sevenZipPath
            Write-Status "7-Zip found at: $($sevenZipPath)"
        }
        else {
            Write-Status "7-Zip not found in default locations. Please enter the path manually or download it."
        }
    })

$Download7ZipButton.Add_Click({
        Write-Status "Opening 7-Zip download page..."
        Start-Process "https://www.7-zip.org/download.html"
    })
$ExtractButton.Add_Click({
        $ExtractButton.IsEnabled = $false
        $LaunchSetupButton.IsEnabled = $false
        Write-Status "`n`nCommencing extraction process..."

        $targetFolder = $TargetPathTextBox.Text
        $sevenZipPath = $SevenZipPathTextBox.Text

        if (!(Test-Path $targetFolder)) {
            Write-Status "Error: Game folder path not found."
            $ExtractButton.IsEnabled = $true
            return
        }
        if (!(Test-Path $sevenZipPath)) {
            Write-Status "Error: 7-Zip path not found. Please find it or download it."
            $ExtractButton.IsEnabled = $true
            return
        }

        $rarFiles = Get-ChildItem -Path $targetFolder -Filter "*.rar"

        $scriptBlock = {
            param($Queue, $RarFiles, $SevenZipPath, $TargetFolder)

            $Queue.Enqueue("Extraction job started in background...")
        
            try {
                foreach ($file in $RarFiles) {
                    $fileName = $file.Name
                    if ($fileName -match "\.part0*1\.rar$" -or ($fileName -notmatch "\.part\d+\.rar$")) {
                        $Queue.Enqueue("Extracting $fileName...")
                    
                        $arguments = "x `"$($file.FullName)`" -o`"$TargetFolder`" -y"

                        $psi = New-Object System.Diagnostics.ProcessStartInfo
                        $psi.FileName = $SevenZipPath
                        $psi.Arguments = $arguments
                        $psi.RedirectStandardOutput = $true
                        $psi.RedirectStandardError = $true
                        $psi.UseShellExecute = $false
                        $psi.CreateNoWindow = $true

                        $process = [System.Diagnostics.Process]::Start($psi)
                        while (!$process.StandardOutput.EndOfStream) {
                            $line = $process.StandardOutput.ReadLine()
                            if ($line.Trim()) {
                                $Queue.Enqueue($line)
                            }
                        }
                        $process.WaitForExit()

                        if ($process.ExitCode -ne 0) {
                            $Queue.Enqueue("Extraction failed for $fileName. Exit code: $($process.ExitCode)")
                            $Queue.Enqueue("__ExtractionComplete__")
                            return
                        }
                        else {
                            $Queue.Enqueue("Extraction complete for $fileName")
                        }
                    }
                    else {
                        $Queue.Enqueue("Skipping $fileName (handled by part01)")
                    }
                }
            }
            catch {
                $Queue.Enqueue("An error occurred during extraction: $_")
            }
            $Queue.Enqueue("__ExtractionComplete__")
        }

        # Corrected runspace and PowerShell object setup
        $runspace = [System.Management.Automation.Runspaces.RunspaceFactory]::CreateRunspace()
        $runspace.Open()

        $powershell = [System.Management.Automation.PowerShell]::Create()
        $powershell.Runspace = $runspace
        $powershell.AddScript($scriptBlock).AddParameter("Queue", $global:outputQueue)
        $powershell.AddParameter("RarFiles", $rarFiles)
        $powershell.AddParameter("SevenZipPath", $sevenZipPath)
        $powershell.AddParameter("TargetFolder", $targetFolder)

        # Begin the invocation and save the job
        $global:extractionJob = $powershell.BeginInvoke()

        # Start the timer to check the queue
        $global:timer = New-Object System.Windows.Threading.DispatcherTimer
        $global:timer.Interval = [TimeSpan]::FromMilliseconds(100)
        $global:timer.Add_Tick({
                $line = $null
                while ($global:outputQueue.TryDequeue([ref]$line)) {
                    if ($line -eq "__ExtractionComplete__") {
                        $global:timer.Stop()
            
                        # Add this check to prevent the error
                        if ($runspace) {
                            $runspace.Close()
                            $runspace = $null
                        }
            
                        Write-Status "`nExtraction finished. Click 'Launch Setup.exe' to proceed with verification or installation."
            
                        $LaunchSetupButton.IsEnabled = $true
                        $ExtractButton.IsEnabled = $true
            
                    }
                    else {
                        Write-Status $line
                    }
                }
            })
        $global:timer.Start()
    })

# This is the new, separated event handler for the LaunchSetupButton
$LaunchSetupButton.Add_Click({
        $LaunchSetupButton.IsEnabled = $false
        Write-Status "`nLaunching setup and verification process..."
    
        $targetFolder = $TargetPathTextBox.Text
    
        $verifyBat = Join-Path $targetFolder "Verify BIN files before installation.bat"
        $md5Folder = Join-Path $targetFolder "MD5"
        $quickSFV = Join-Path $md5Folder "QuickSFV.exe"
        $md5File = Join-Path $md5Folder "fitgirl-bins.md5"

        if (Test-Path $verifyBat) {
            Write-Status "Launching 'Verify BIN files' batch file..."
            Start-Process -FilePath $verifyBat -Wait
        }
        elseif (Test-Path $quickSFV -and (Test-Path $md5File)) {
            Write-Status "Launching QuickSFV to verify files..."
            Start-Process -FilePath $quickSFV -ArgumentList "`"$md5File`"" -Wait
        }
        else {
            Write-Status "No verification method found. Please check your setup folder."
        }

        # After verification is done, launch the main setup file
        $setupFile = Join-Path $targetFolder "setup.exe"
        if (Test-Path $setupFile) {
            Write-Status "`nLaunching setup.exe..."
            Start-Process -FilePath $setupFile
        }
        else {
            Write-Status "`nError: setup.exe not found in the game folder."
        }

        $LaunchSetupButton.IsEnabled = $true

    })
$window.Add_Closing({
        if ($global:timer) { $global:timer.Stop() }
        if ($global:extractionJob) { Remove-Job -Force $global:extractionJob }
    })

# Show the GUI window
$window.ShowDialog()