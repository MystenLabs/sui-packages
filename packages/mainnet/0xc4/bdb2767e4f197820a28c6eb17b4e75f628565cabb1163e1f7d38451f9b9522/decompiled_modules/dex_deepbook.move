module 0xc4bdb2767e4f197820a28c6eb17b4e75f628565cabb1163e1f7d38451f9b9522::dex_deepbook {
    public fun calculate_swap_output(arg0: u64, arg1: bool) : u64 {
        arg0 * 9985 / 10000
    }

    public fun check_token_compatibility() : bool {
        true
    }

    public entry fun flash_loan_arbitrage(arg0: 0x1::string::String, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::tx_context::sender(arg2);
    }

    public fun get_deepbook_package() : address {
        @0xdee9
    }

    public fun get_flash_loan_fee() : u64 {
        5
    }

    public fun get_gas_reduction() : u64 {
        60
    }

    public fun get_min_trade_amount() : u64 {
        100
    }

    public fun get_sui_wusdc_pool() : address {
        @0xdee9
    }

    public fun get_trading_fee() : u64 {
        15
    }

    public fun supports_atomic_execution() : bool {
        true
    }

    public fun supports_clob() : bool {
        true
    }

    public fun supports_flash_loans() : bool {
        true
    }

    public fun supports_wusdc() : bool {
        true
    }

    public fun swap_sui_to_wusdc<T0>(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: 0x2::object::ID, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg0, 0x2::tx_context::sender(arg3));
        abort 3
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

    // decompiled from Move bytecode v6
}

