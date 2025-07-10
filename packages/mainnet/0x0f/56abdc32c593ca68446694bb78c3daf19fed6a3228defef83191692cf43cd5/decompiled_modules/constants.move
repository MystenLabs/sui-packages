module 0xf56abdc32c593ca68446694bb78c3daf19fed6a3228defef83191692cf43cd5::constants {
    public fun get_default_gas_budget() : u64 {
        100000000
    }

    public fun get_default_slippage_bps() : u64 {
        100
    }

    public fun get_dex_id(arg0: &vector<u8>) : u8 {
        let v0 = b"kriya";
        if (arg0 == &v0) {
            1
        } else {
            let v2 = b"turbos";
            if (arg0 == &v2) {
                2
            } else {
                let v3 = b"cetus";
                if (arg0 == &v3) {
                    3
                } else {
                    let v4 = b"aftermath";
                    if (arg0 == &v4) {
                        4
                    } else {
                        let v5 = b"bluefin";
                        if (arg0 == &v5) {
                            5
                        } else {
                            let v6 = b"deepbook";
                            if (arg0 == &v6) {
                                6
                            } else {
                                0
                            }
                        }
                    }
                }
            }
        }
    }

    public fun get_exact_sui_amount() : u64 {
        10000000
    }

    public fun get_sui_type() : vector<u8> {
        b"0x2::sui::SUI"
    }

    public fun get_wusdc_type() : vector<u8> {
        b"0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN"
    }

    public fun is_valid_dex_id(arg0: u8) : bool {
        arg0 >= 1 && arg0 <= 6
    }

    public fun is_valid_slippage(arg0: u64) : bool {
        arg0 <= 1000
    }

    // decompiled from Move bytecode v6
}

