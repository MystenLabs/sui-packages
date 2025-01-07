module 0x4d9d9d39e92265195f16b34a02f2608c92aec02e51fa76a39e07da4d2ef90488::my_module {
    struct Sword has store, key {
        id: 0x2::object::UID,
        magic: u64,
        strength: u64,
    }

    struct Forge has store, key {
        id: 0x2::object::UID,
        swords_created: u64,
    }

    struct SwapEvent has copy, drop {
        amount_y_out: u64,
    }

    struct AdminData has copy, drop, store {
        dao_fee_to: address,
        admin_address: address,
        dao_fee: u64,
        swap_fee: u64,
        dao_fee_on: bool,
        is_pause: bool,
    }

    public fun animeswap_get_amount_out<T0, T1>(arg0: u64, arg1: &mut 0x88d362329ede856f5f67867929ed570bba06c975abec2fab7f0601c56f6a8cb1::animeswap::LiquidityPools) : u64 {
        if (0x88d362329ede856f5f67867929ed570bba06c975abec2fab7f0601c56f6a8cb1::animeswap_library::compare<T0, T1>()) {
            let (v1, _) = 0x88d362329ede856f5f67867929ed570bba06c975abec2fab7f0601c56f6a8cb1::animeswap::get_pool<T0, T1>(arg1);
            let (v3, v4) = 0x88d362329ede856f5f67867929ed570bba06c975abec2fab7f0601c56f6a8cb1::animeswap::get_reserves_size<T0, T1>(v1);
            0x88d362329ede856f5f67867929ed570bba06c975abec2fab7f0601c56f6a8cb1::animeswap_library::get_amount_out(arg0, v3, v4, 30)
        } else {
            let (v5, _) = 0x88d362329ede856f5f67867929ed570bba06c975abec2fab7f0601c56f6a8cb1::animeswap::get_pool<T1, T0>(arg1);
            let (v7, v8) = 0x88d362329ede856f5f67867929ed570bba06c975abec2fab7f0601c56f6a8cb1::animeswap::get_reserves_size<T1, T0>(v5);
            0x88d362329ede856f5f67867929ed570bba06c975abec2fab7f0601c56f6a8cb1::animeswap_library::get_amount_out(arg0, v8, v7, 30)
        }
    }

    public entry fun animeswap_swap<T0, T1>(arg0: &mut 0x88d362329ede856f5f67867929ed570bba06c975abec2fab7f0601c56f6a8cb1::animeswap::LiquidityPools, arg1: &0x2::clock::Clock, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = animeswap_get_amount_out<T0, T1>(arg3, arg0);
        let v1 = SwapEvent{amount_y_out: v0};
        0x2::event::emit<SwapEvent>(v1);
        0x88d362329ede856f5f67867929ed570bba06c975abec2fab7f0601c56f6a8cb1::animeswap::swap_exact_coins_for_coins_entry<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Forge{
            id             : 0x2::object::new(arg0),
            swords_created : 0,
        };
        0x2::transfer::transfer<Forge>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun magic(arg0: &Sword) : u64 {
        arg0.magic
    }

    public fun strength(arg0: &Sword) : u64 {
        arg0.strength
    }

    public entry fun swap_3<T0, T1, T2, T3>(arg0: &mut 0x88d362329ede856f5f67867929ed570bba06c975abec2fab7f0601c56f6a8cb1::animeswap::LiquidityPools, arg1: &0x2::clock::Clock, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        0x88d362329ede856f5f67867929ed570bba06c975abec2fab7f0601c56f6a8cb1::animeswap::swap_exact_coins_for_coins_entry<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public fun swords_created(arg0: &Forge) : u64 {
        arg0.swords_created
    }

    // decompiled from Move bytecode v6
}

