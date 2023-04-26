# I2S to TDA1540's Offset Binary Converter
Welcome to the repository for I2S to Offset Binary Converter.

- [Why?](#why)
- [Inspiration](#inspiration)
- [Features](#features)
- [Code](#code)
- [IDE](#ide)
- [Supported devices](#devices)
- [References](#references)

---
## <a name="why">Why?</a>
I am a little audio freak and I like building my own audio devices. Having a lot of fancy and very expensive audio staff one day I have decided to try to do the audio my way, exactly how I like. My adventure with DACs began with the Philips TDA1541 chip. Then I have tried TDA1543, PCM63, PCM56, PCM58, AD1864, AD1865 and a lot more. I have noticed that the older the chip the more it suits my audio taste. So ... I finally bought the TDA1540p and TDA1540D chips. However, due to its vintage specification, hardly any hardware is needed to cope with the TDA1540 input format.  And here we are - TDA1540's Offset Binary Converter.

---
## <a name="inspiration">Inspiration</a>
I have been looking for a solution to my problem for some time. The first was a converter I bought on eBay (I2S is TDA1540 PCM56P PCM58P PCM61P AD1856N AD1860N AD1862N AD1865N) from user chiurutu. Thanks to this board, I was able to run the TDA1540 and fell in love with its sound. Unfortunately, I had to find a more flexible solution. So I found the forum [**thread**](https://www.diyaudio.com/community/threads/tda1540-i2s-to-offset-binary-no-cpld-no-fpga.341478/), which inspired me to delve into FPGAs and had a huge influence on the current codes for this project.

---
## <a name="features">Features</a>
* Converts I2S format into TDA1540 input format.
* Supports two I2S inputs selected by a push button.
* Supports 30s mute after turning on.
* Supports standard and stopped clock for BCK (TDA's clock pulse input) output.

---
## <a name="code">Code</a>

* [**I2S.bdf**](I2S.bdf)
Main entry, block schema.

* [**input_selector.v**](input_selector.v)
Verilog code for input selection function.

* [**mute_sck.v**](mute_sck.v)
Verilog code for mute function.
    
---
## <a name="ide">IDE</a>
I am using [**Intel® Quartus® Prime Lite Edition**](https://www.intel.pl/content/www/pl/pl/products/details/fpga/development-tools/quartus-prime/resource.html) running on the Linux VM.

---
## <a name="devices">Supported devices</a>
I am using those codes running the [**Intel Altera Max II EMP240 CPLD**](https://www.intel.pl/content/www/pl/pl/products/sku/210264/max-ii-epm240-cpld/specifications.html).

Tested with I2S input:
* DATA: 16-24 bits
* LE: 44.1kHZ, 48kHZ, 88.2kHZ, 96kHZ (should also work with 176.4kHZ)

---
## <a name="references">References</a>
* [**A Monolithic 14 Bit DA Converter**](pdf/A-Monolithic-14-Bit-DA-Converter.pdf)
* [**Dynamic Element Matching for High Acuracy Monolithic DAC**](pdf/Dynamic-Element-Matching-for-High-Acuracy-Monolithic-DAC.pdf)
* [**I2S Bus**](pdf/I2S.pdf)
* [**TDA1540D**](pdf/TDA1540D.pdf)
* [**TDA1540P**](pdf/TDA1540P.pdf)
