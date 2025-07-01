module 0xc4bdb2767e4f197820a28c6eb17b4e75f628565cabb1163e1f7d38451f9b9522::dex_aftermath {
    public fun calculate_swap_output(arg0: u64, arg1: bool) : u64 {
        arg0 * 999 / 1000
    }

    public fun check_token_compatibility() : bool {
        true
    }

    public fun get_aftermath_package() : address {
        @0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d37ca240
    }

    public fun get_min_trade_amount() : u64 {
        1
    }

    public fun get_routing_protocols() : vector<0x1::string::String> {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"Hop"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"Momentum"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"7K"));
        v0
    }

    public fun get_sui_wusdc_router() : address {
        @0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d37ca240
    }

    public fun get_trading_fee() : u64 {
        0
    }

    public fun supports_wusdc() : bool {
        true
    }

    public entry fun swap_sui_to_wusdc(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: 0x2::object::ID, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg0, 0x2::tx_context::sender(arg3));
    }

    public fun swap_wusdc_to_sui<T0>(arg0: 0x2::coin::Coin<T0>, arg1: 0x2::object::ID, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, 0x2::tx_context::sender(arg3));
        abort 3
    }

    public entry fun swap_wusdc_to_sui_entry<T0>(arg0: 0x2::coin::Coin<T0>, arg1: 0x2::object::ID, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(swap_wusdc_to_sui<T0>(arg0, arg1, arg2, arg3), v0);
    }

    public fun validate_pool(arg0: address) : bool {
        arg0 != @0x0
    }

    public fun validate_smart_routing() : bool {
        true
    }

    // decompiled from Move bytecode v6
}

