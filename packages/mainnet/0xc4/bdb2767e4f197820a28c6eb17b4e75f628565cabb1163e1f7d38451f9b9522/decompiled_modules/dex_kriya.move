module 0xc4bdb2767e4f197820a28c6eb17b4e75f628565cabb1163e1f7d38451f9b9522::dex_kriya {
    public fun check_token_compatibility() : bool {
        true
    }

    public fun get_sui_wusdc_pool() : address {
        @0x5af4976b871fa1813362f352fa4cada3883a96191bb7212db1bd5d13685ae305
    }

    public fun supports_wusdc() : bool {
        true
    }

    public fun swap_sui_to_wusdc<T0>(arg0: 0x2::object::ID, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: u64, arg3: u64) : 0x2::coin::Coin<T0> {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, @0x0);
        abort 1
    }

    public fun validate_pool(arg0: address) : bool {
        arg0 == @0x5af4976b871fa1813362f352fa4cada3883a96191bb7212db1bd5d13685ae305
    }

    // decompiled from Move bytecode v6
}

