/*
 * SPDX-FileCopyrightText: 2020 Efabless Corporation
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 * SPDX-License-Identifier: Apache-2.0
 */

// This include is relative to $CARAVEL_PATH (see Makefile)
#include <defs.h>
#include <stub.c>

#define tx_data (*(volatile uint32_t*)0x30000008)
#define tx_start (*(volatile uint32_t*)0x30000010)

/*
	Wishbone Test:
		- Configures MPRJ lower 8-IO pins as outputs
		- Checks counter value through the wishbone port
*/

void main()
{
  reg_wb_enable = 1;
  reg_mprj_io_31 = GPIO_MODE_USER_STD_OUTPUT;

  reg_mprj_xfer = 1;
  while (reg_mprj_xfer == 1);

  while(tx_start == 0x00000000) {
    tx_data = 0x00000041;
    tx_start = 0x000000001;
  }
}
