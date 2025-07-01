module 0xe7872fc789b4b970b01e7c64ab75dd5adeeff8197c3b89bb9adbef8c9343f187::constants {
    public fun aftermath_package() : address {
        @0xf325ce1300e8dac124071d3152c5c5ee6174914f8bc2161e88329cf579246efc
    }

    public fun aftermath_wusdc_sui_pool() : address {
        @0xfe25614a57b5979cfa37fc4f9d269b0aae16ba25718b82f72dcfe7b123e45607
    }

    public fun bluefin_package() : address {
        @0x3492c874c1e3b3e2984e8c99b4d4e5f6a7b8c9d0e1f2a3b4c5d6e7f8a9b0c1d2
    }

    public fun buck_type() : vector<u8> {
        b"0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK"
    }

    public fun cetus_package() : address {
        @0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb
    }

    public fun cetus_sui_wusdc_pool() : address {
        @0xcf994611fd4c48e277ce3ffd4d4364c914af2c3cbb05f7bf6facd371de688630
    }

    public fun clock_object() : address {
        @0x6
    }

    public fun deepbook_package() : address {
        @0xdee9
    }

    public fun enforce_cross_dex() : bool {
        true
    }

    public fun is_approved_dex(arg0: address) : bool {
        if (arg0 == @0xf325ce1300e8dac124071d3152c5c5ee6174914f8bc2161e88329cf579246efc) {
            true
        } else if (arg0 == @0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1) {
            true
        } else if (arg0 == @0xdee9) {
            true
        } else if (arg0 == @0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66) {
            true
        } else if (arg0 == @0x3492c874c1e3b3e2984e8c99b4d4e5f6a7b8c9d0e1f2a3b4c5d6e7f8a9b0c1d2) {
            true
        } else {
            arg0 == @0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb
        }
    }

    public fun is_approved_intermediate(arg0: vector<u8>) : bool {
        if (arg0 == b"0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN") {
            true
        } else if (arg0 == b"0xc060006111016b8a020ad5b33834984a437aaa7d3c74c18e09a95d48aceab08c::coin::COIN") {
            true
        } else {
            arg0 == b"0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK"
        }
    }

    public fun kriya_package() : address {
        @0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66
    }

    public fun max_intermediate_tokens() : u64 {
        1
    }

    public fun min_output_amount() : u64 {
        1
    }

    public fun sui_input_amount() : u64 {
        100000000
    }

    public fun turbos_package() : address {
        @0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1
    }

    public fun usdt_type() : vector<u8> {
        b"0xc060006111016b8a020ad5b33834984a437aaa7d3c74c18e09a95d48aceab08c::coin::COIN"
    }

    public fun wusdc_type() : vector<u8> {
        b"0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN"
    }

    // decompiled from Move bytecode v6
}

