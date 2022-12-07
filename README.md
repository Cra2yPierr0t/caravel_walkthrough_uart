## CSR

* byte_size
    * 20

|name|offset_address|
|:--|:--|
|[CLOCK_FREQ](#CSR-CLOCK_FREQ)|0x00|
|[RECEIVED_DATA](#CSR-RECEIVED_DATA)|0x04|
|[TRANSMISSION_DATA](#CSR-TRANSMISSION_DATA)|0x08|
|[INTERRUPT_ENABLE](#CSR-INTERRUPT_ENABLE)|0x0c|
|[TRANSMISSION_START](#CSR-TRANSMISSION_START)|0x10|

### <div id="CSR-CLOCK_FREQ"></div>CLOCK_FREQ

* offset_address
    * 0x00
* type
    * default

|name|bit_assignments|type|initial_value|reference|comment|
|:--|:--|:--|:--|:--|:--|
|clock_freq|[31:0]|rw|0x0001c200|||

### <div id="CSR-RECEIVED_DATA"></div>RECEIVED_DATA

* offset_address
    * 0x04
* type
    * default

|name|bit_assignments|type|initial_value|reference|comment|
|:--|:--|:--|:--|:--|:--|
|rx|[7:0]|rotrg|0x00|||
|reserved|[31:8]|reserved||||

### <div id="CSR-TRANSMISSION_DATA"></div>TRANSMISSION_DATA

* offset_address
    * 0x08
* type
    * default

|name|bit_assignments|type|initial_value|reference|comment|
|:--|:--|:--|:--|:--|:--|
|tx|[7:0]|rw|0x00|||
|reserved|[31:8]|reserved||||

### <div id="CSR-INTERRUPT_ENABLE"></div>INTERRUPT_ENABLE

* offset_address
    * 0x0c
* type
    * default

|name|bit_assignments|type|initial_value|reference|comment|
|:--|:--|:--|:--|:--|:--|
|irq_en|[0]|rw|0x1|||
|reserved|[30:1]|reserved||||

### <div id="CSR-TRANSMISSION_START"></div>TRANSMISSION_START

* offset_address
    * 0x10
* type
    * default

|name|bit_assignments|type|initial_value|reference|comment|
|:--|:--|:--|:--|:--|:--|
|tx_start|[0]|rwc|0x0|||
|reserved|[30:1]|reserved||||
