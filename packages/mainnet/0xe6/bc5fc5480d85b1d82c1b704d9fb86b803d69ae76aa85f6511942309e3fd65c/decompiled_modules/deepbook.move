module 0xe6bc5fc5480d85b1d82c1b704d9fb86b803d69ae76aa85f6511942309e3fd65c::deepbook {
    public fun check<T0, T1>(arg0: &mut 0xe6bc5fc5480d85b1d82c1b704d9fb86b803d69ae76aa85f6511942309e3fd65c::probe::Probe, arg1: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: bool, arg3: bool, arg4: &0x2::clock::Clock) {
        if (!0xe6bc5fc5480d85b1d82c1b704d9fb86b803d69ae76aa85f6511942309e3fd65c::probe::checking(arg0)) {
            return
        };
        let v0 = 0xe6bc5fc5480d85b1d82c1b704d9fb86b803d69ae76aa85f6511942309e3fd65c::probe::check_amount(arg0);
        let (v1, v2) = if (arg2) {
            let (v3, v4, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_quote_quantity_out_input_fee<T0, T1>(arg1, v0, arg4);
            (v0 - v3, v4)
        } else {
            let (v6, v7, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_base_quantity_out_input_fee<T0, T1>(arg1, v0, arg4);
            (v0 - v7, v6)
        };
        0xe6bc5fc5480d85b1d82c1b704d9fb86b803d69ae76aa85f6511942309e3fd65c::probe::check_step(arg0, v1, v2, arg3);
    }

    public fun fold<T0, T1>(arg0: &mut 0xe6bc5fc5480d85b1d82c1b704d9fb86b803d69ae76aa85f6511942309e3fd65c::probe::Probe, arg1: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: bool, arg3: u64, arg4: &0x2::clock::Clock) {
        let (v0, v1) = if (arg2) {
            let (v2, v3, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_quote_quantity_out_input_fee<T0, T1>(arg1, arg3, arg4);
            (arg3 - v2, v3)
        } else {
            let (v5, v6, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_base_quantity_out_input_fee<T0, T1>(arg1, arg3, arg4);
            (arg3 - v6, v5)
        };
        if (v0 == 0 || v1 == 0) {
            0xe6bc5fc5480d85b1d82c1b704d9fb86b803d69ae76aa85f6511942309e3fd65c::probe::fold_closed(arg0);
            return
        };
        0xe6bc5fc5480d85b1d82c1b704d9fb86b803d69ae76aa85f6511942309e3fd65c::probe::fold_to(arg0, (v1 as u256), 0, (v0 as u256), (v0 as u256));
    }

    public fun fold_live<T0, T1>(arg0: &mut 0xe6bc5fc5480d85b1d82c1b704d9fb86b803d69ae76aa85f6511942309e3fd65c::probe::Probe, arg1: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: bool, arg3: &0x2::clock::Clock) {
        let v0 = 0xe6bc5fc5480d85b1d82c1b704d9fb86b803d69ae76aa85f6511942309e3fd65c::probe::reference_input(arg0);
        fold<T0, T1>(arg0, arg1, arg2, v0, arg3);
    }

    public fun lendable<T0, T1>(arg0: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: bool, arg2: u64) : u64 {
        let (v0, v1, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::vault_balances<T0, T1>(arg0);
        let v3 = if (arg1) {
            v0
        } else {
            v1
        };
        if (v3 < arg2) {
            v3
        } else {
            arg2
        }
    }

    // decompiled from Move bytecode v7
}

