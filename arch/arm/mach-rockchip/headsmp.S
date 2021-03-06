/*
 * Copyright (c) 2013 MundoReader S.L.
 * Author: Heiko Stuebner <heiko@sntech.de>
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 */
#include <linux/linkage.h>
#include <linux/init.h>

ENTRY(rockchip_secondary_startup)
	bl	v7_invalidate_l1
	b	secondary_startup
ENDPROC(rockchip_secondary_startup)

ENTRY(rk3288_secondary_startup)
	mrc p15, 0, r0, c0, c0, 5
	mov r2, #3
	and r0, r0, r2
	ldr r1, =0xff700000
	ldr r1, [r1]
	cmp r0, r1
	beq 2f
	ldr r2, =0xfffd0000
	mov pc, r2
2:
	b	secondary_startup
ENDPROC(rk3288_secondary_startup)

ENTRY(rockchip_secondary_trampoline)
	ldr	pc, 1f
ENDPROC(rockchip_secondary_trampoline)
	.globl	rockchip_boot_fn
rockchip_boot_fn:
1:	.space	4

ENTRY(rockchip_secondary_trampoline_end)
