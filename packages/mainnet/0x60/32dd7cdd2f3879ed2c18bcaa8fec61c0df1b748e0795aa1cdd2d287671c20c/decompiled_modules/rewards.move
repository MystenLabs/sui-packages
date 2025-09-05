module 0x6032dd7cdd2f3879ed2c18bcaa8fec61c0df1b748e0795aa1cdd2d287671c20c::rewards {
    fun accrue_performance_fee(arg0: &mut 0x6032dd7cdd2f3879ed2c18bcaa8fec61c0df1b748e0795aa1cdd2d287671c20c::vault::Vault, arg1: &mut 0x2::coin::TreasuryCap<0x6032dd7cdd2f3879ed2c18bcaa8fec61c0df1b748e0795aa1cdd2d287671c20c::vault::VAULT>, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext, arg5: u64) {
        if (arg2 <= 0x6032dd7cdd2f3879ed2c18bcaa8fec61c0df1b748e0795aa1cdd2d287671c20c::vault::get_hwm(arg0)) {
            0x6032dd7cdd2f3879ed2c18bcaa8fec61c0df1b748e0795aa1cdd2d287671c20c::vault::set_hwm(arg0, arg2);
            return
        };
        let v0 = arg3 * 0x6032dd7cdd2f3879ed2c18bcaa8fec61c0df1b748e0795aa1cdd2d287671c20c::vault::get_fee_bps(arg0) / 10000;
        if (v0 == 0) {
            0x6032dd7cdd2f3879ed2c18bcaa8fec61c0df1b748e0795aa1cdd2d287671c20c::vault::set_hwm(arg0, arg2);
            return
        };
        let v1 = (((v0 as u128) * (0x6032dd7cdd2f3879ed2c18bcaa8fec61c0df1b748e0795aa1cdd2d287671c20c::vault::get_total_shares(arg0) as u128) / (arg5 as u128)) as u64);
        if (v1 > 0) {
            0x6032dd7cdd2f3879ed2c18bcaa8fec61c0df1b748e0795aa1cdd2d287671c20c::vault::add_total_shares(arg0, v1);
            0x2::transfer::public_freeze_object<0x2::coin::Coin<0x6032dd7cdd2f3879ed2c18bcaa8fec61c0df1b748e0795aa1cdd2d287671c20c::vault::VAULT>>(0x2::coin::mint<0x6032dd7cdd2f3879ed2c18bcaa8fec61c0df1b748e0795aa1cdd2d287671c20c::vault::VAULT>(arg1, v1, arg4));
        };
        0x6032dd7cdd2f3879ed2c18bcaa8fec61c0df1b748e0795aa1cdd2d287671c20c::vault::set_hwm(arg0, arg2);
        0x6032dd7cdd2f3879ed2c18bcaa8fec61c0df1b748e0795aa1cdd2d287671c20c::vault::emit_performance_fee_event(arg0, v1, 0x6032dd7cdd2f3879ed2c18bcaa8fec61c0df1b748e0795aa1cdd2d287671c20c::vault::get_fee_recipient(arg0));
    }

    public entry fun get_reward_and_compound(arg0: &mut 0x6032dd7cdd2f3879ed2c18bcaa8fec61c0df1b748e0795aa1cdd2d287671c20c::vault::Vault, arg1: &mut 0x2::coin::TreasuryCap<0x6032dd7cdd2f3879ed2c18bcaa8fec61c0df1b748e0795aa1cdd2d287671c20c::vault::VAULT>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x6032dd7cdd2f3879ed2c18bcaa8fec61c0df1b748e0795aa1cdd2d287671c20c::vault::get_sui_balance(arg0) + arg2;
        let v1 = (((v0 as u128) * 1000000000000 / (0x6032dd7cdd2f3879ed2c18bcaa8fec61c0df1b748e0795aa1cdd2d287671c20c::vault::get_total_shares(arg0) as u128)) as u64);
        accrue_performance_fee(arg0, arg1, v1, arg2, arg3, v0);
    }

    // decompiled from Move bytecode v6
}

