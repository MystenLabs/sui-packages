module 0x91b664ec122ae46c29f6883cc1f40a39f47ac736e545407ba3940bd108958f67::pair {
    struct LP<phantom T0, phantom T1> has drop {
        dummy_field: bool,
    }

    struct PairMetadata<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        reserve_x: 0x2::coin::Coin<T0>,
        reserve_y: 0x2::coin::Coin<T1>,
        k_last: u128,
        lp_supply: 0x2::balance::Supply<LP<T0, T1>>,
        fee_rate: u64,
    }

    struct LiquidityAdded has copy, drop {
        user: address,
        coin_x: 0x1::string::String,
        coin_y: 0x1::string::String,
        amount_x: u64,
        amount_y: u64,
        liquidity: u64,
        fee: u64,
    }

    struct LiquidityRemoved has copy, drop {
        user: address,
        coin_x: 0x1::string::String,
        coin_y: 0x1::string::String,
        amount_x: u64,
        amount_y: u64,
        liquidity: u64,
        fee: u64,
    }

    struct Swapped has copy, drop {
        user: address,
        coin_x: 0x1::string::String,
        coin_y: 0x1::string::String,
        amount_x_in: u64,
        amount_y_in: u64,
        amount_x_out: u64,
        amount_y_out: u64,
    }

    public fun swap<T0, T1>(arg0: &mut PairMetadata<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: 0x2::coin::Coin<T1>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        abort 0
    }

    public fun burn<T0, T1>(arg0: &mut PairMetadata<T0, T1>, arg1: &0x91b664ec122ae46c29f6883cc1f40a39f47ac736e545407ba3940bd108958f67::treasury::Treasury, arg2: 0x2::coin::Coin<LP<T0, T1>>, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        abort 0
    }

    fun burn_lp<T0, T1>(arg0: &mut PairMetadata<T0, T1>, arg1: 0x2::coin::Coin<LP<T0, T1>>) {
        abort 0
    }

    fun deposit_x<T0, T1>(arg0: &mut PairMetadata<T0, T1>, arg1: 0x2::coin::Coin<T0>) {
        abort 0
    }

    fun deposit_y<T0, T1>(arg0: &mut PairMetadata<T0, T1>, arg1: 0x2::coin::Coin<T1>) {
        abort 0
    }

    fun extract_x<T0, T1>(arg0: &mut PairMetadata<T0, T1>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        abort 0
    }

    fun extract_y<T0, T1>(arg0: &mut PairMetadata<T0, T1>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        abort 0
    }

    public fun fee_rate<T0, T1>(arg0: &PairMetadata<T0, T1>) : u64 {
        abort 0
    }

    public fun get_lp_name<T0, T1>() : 0x1::string::String {
        abort 0
    }

    public fun get_reserves<T0, T1>(arg0: &PairMetadata<T0, T1>) : (u64, u64) {
        abort 0
    }

    public fun k<T0, T1>(arg0: &PairMetadata<T0, T1>) : u128 {
        abort 0
    }

    public fun mint<T0, T1>(arg0: &mut PairMetadata<T0, T1>, arg1: &0x91b664ec122ae46c29f6883cc1f40a39f47ac736e545407ba3940bd108958f67::treasury::Treasury, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::coin::Coin<T1>, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<LP<T0, T1>> {
        abort 0
    }

    fun mint_fee<T0, T1>(arg0: &mut PairMetadata<T0, T1>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) : u64 {
        abort 0
    }

    fun mint_lp<T0, T1>(arg0: &mut PairMetadata<T0, T1>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<LP<T0, T1>> {
        abort 0
    }

    public fun total_lp_supply<T0, T1>(arg0: &PairMetadata<T0, T1>) : u64 {
        abort 0
    }

    fun update_k_last<T0, T1>(arg0: &mut PairMetadata<T0, T1>) {
        abort 0
    }

    // decompiled from Move bytecode v6
}

