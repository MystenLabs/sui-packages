module 0x3987aa0d0285bae458be4789bd78e1073ba7ca38442a503b4ca081004277a244::shop {
    struct KongBot<phantom T0> has key {
        id: 0x2::object::UID,
        bot_fee: u64,
        banana_fee: u64,
        balance: 0x2::balance::Balance<T0>,
        bananas_actives: 0x2::table::Table<address, Banana<T0>>,
    }

    struct BotOwnerCap has key {
        id: 0x2::object::UID,
    }

    struct Banana<phantom T0> has store, key {
        id: 0x2::object::UID,
        admin: address,
        rewards: 0x2::balance::Balance<T0>,
    }

    public fun blue_move_swap<T0, T1>(arg0: &mut KongBot<T0>, arg1: &mut Banana<T0>, arg2: u64, arg3: u64, arg4: &mut 0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::swap::Dex_Info, arg5: 0x2::coin::Coin<T0>, arg6: bool, arg7: &mut 0x2::tx_context::TxContext) {
        if (arg6) {
            let (v0, v1) = transfer_bananas<T0>(arg0, arg1, arg5, arg7);
            0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::router::swap_exact_input<T0, T1>(v0, v1, arg3, arg4, arg7);
        } else {
            let v2 = 0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::router::swap_exact_input_<T0, T1>(arg2, arg5, arg3, arg4, arg7);
            let (_, v4) = get_fee<T1>(&v2);
            let (v5, v6) = get_coin_fee<T1>(v2, v4, arg7);
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v5, 0x2::tx_context::sender(arg7));
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v6, @0x4b57068af6be5bb31ddbb70da8819856ea590f741a62cbe97ef4f80d47336875);
        };
    }

    public entry fun create_banana<T0>(arg0: &mut KongBot<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(!0x2::table::contains<address, Banana<T0>>(&arg0.bananas_actives, v0), 0);
        let v1 = Banana<0x2::sui::SUI>{
            id      : 0x2::object::new(arg1),
            admin   : v0,
            rewards : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        0x2::transfer::share_object<Banana<0x2::sui::SUI>>(v1);
    }

    fun get_coin_fee<T0>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T0>) {
        (arg0, 0x2::coin::split<T0>(&mut arg0, arg1, arg2))
    }

    fun get_fee<T0>(arg0: &0x2::coin::Coin<T0>) : (u64, u64) {
        let v0 = 0x2::coin::value<T0>(arg0);
        let v1 = v0 * 990 / 1000;
        (v1, v0 - v1)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = BotOwnerCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<BotOwnerCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = KongBot<0x2::sui::SUI>{
            id              : 0x2::object::new(arg0),
            bot_fee         : 1,
            banana_fee      : 30,
            balance         : 0x2::balance::zero<0x2::sui::SUI>(),
            bananas_actives : 0x2::table::new<address, Banana<0x2::sui::SUI>>(arg0),
        };
        0x2::transfer::share_object<KongBot<0x2::sui::SUI>>(v1);
    }

    public fun move_pump_swap<T0>(arg0: &mut 0x92fecee99603c0628ced2fbd37f85c05f6c0049c183eb6b1b58db24764c6c7bc::move_pump::Configuration, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::swap::Dex_Info, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let (_, v1) = get_fee<0x2::sui::SUI>(&arg1);
        let (v2, v3) = get_coin_fee<0x2::sui::SUI>(arg1, v1, arg5);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v3, @0x4b57068af6be5bb31ddbb70da8819856ea590f741a62cbe97ef4f80d47336875);
        0x92fecee99603c0628ced2fbd37f85c05f6c0049c183eb6b1b58db24764c6c7bc::move_pump::buy<T0>(arg0, v2, arg2, arg3, arg4, arg5);
    }

    public fun move_pump_swap_sell<T0>(arg0: &mut 0x92fecee99603c0628ced2fbd37f85c05f6c0049c183eb6b1b58db24764c6c7bc::move_pump::Configuration, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x92fecee99603c0628ced2fbd37f85c05f6c0049c183eb6b1b58db24764c6c7bc::move_pump::sell_returns<T0>(arg0, arg1, arg2, arg3, arg4);
        let v2 = v1;
        let v3 = v0;
        let (_, v5) = get_fee<0x2::sui::SUI>(&v3);
        let (v6, v7) = get_coin_fee<0x2::sui::SUI>(v3, v5, arg4);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v6, 0x2::tx_context::sender(arg4));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v7, @0x4b57068af6be5bb31ddbb70da8819856ea590f741a62cbe97ef4f80d47336875);
        if (0x2::coin::value<T0>(&v2) == 0) {
            0x2::coin::destroy_zero<T0>(v2);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v2, 0x2::tx_context::sender(arg4));
        };
    }

    fun transfer_bananas<T0>(arg0: &mut KongBot<T0>, arg1: &mut Banana<T0>, arg2: 0x2::coin::Coin<T0>, arg3: &mut 0x2::tx_context::TxContext) : (u64, 0x2::coin::Coin<T0>) {
        let v0 = 0x2::coin::value<T0>(&arg2);
        let v1 = v0 * (1000 - arg0.bot_fee * 10) / 1000;
        let v2 = v0 - v1;
        let v3 = v2 * (1000 - arg0.banana_fee * 10) / 1000;
        let v4 = v2 - v3;
        let v5 = 0x2::coin::split<T0>(&mut arg2, v3, arg3);
        0x2::balance::join<T0>(&mut arg0.balance, 0x2::balance::split<T0>(0x2::coin::balance_mut<T0>(&mut v5), v3));
        let v6 = 0x2::coin::split<T0>(&mut arg2, v4, arg3);
        0x2::balance::join<T0>(&mut arg1.rewards, 0x2::balance::split<T0>(0x2::coin::balance_mut<T0>(&mut v6), v4));
        0x2::coin::destroy_zero<T0>(v6);
        0x2::coin::destroy_zero<T0>(v5);
        (v1, arg2)
    }

    public fun turbos_swap_a_b<T0, T1, T2>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg1: vector<0x2::coin::Coin<T0>>, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg6: bool, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg7);
        if (arg6) {
            let v1 = 0x1::vector::pop_back<0x2::coin::Coin<T0>>(&mut arg1);
            let (v2, v3) = get_fee<T0>(&v1);
            let (v4, v5) = get_coin_fee<T0>(v1, v3, arg7);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v5, @0x4b57068af6be5bb31ddbb70da8819856ea590f741a62cbe97ef4f80d47336875);
            0x1::vector::push_back<0x2::coin::Coin<T0>>(&mut arg1, v4);
            0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::swap_router::swap_a_b<T0, T1, T2>(arg0, arg1, v2, arg3, 4295048016, true, v0, 0x2::clock::timestamp_ms(arg4), arg4, arg5, arg7);
        } else {
            let (v6, v7) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::swap_router::swap_a_b_with_return_<T0, T1, T2>(arg0, arg1, arg2, arg3, 4295048016, true, v0, 0x2::clock::timestamp_ms(arg4), arg4, arg5, arg7);
            let v8 = v7;
            let v9 = v6;
            let (_, v11) = get_fee<T1>(&v9);
            let (v12, v13) = get_coin_fee<T1>(v9, v11, arg7);
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v12, v0);
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v13, @0x4b57068af6be5bb31ddbb70da8819856ea590f741a62cbe97ef4f80d47336875);
            if (0x2::coin::value<T0>(&v8) == 0) {
                0x2::coin::destroy_zero<T0>(v8);
            } else {
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v8, v0);
            };
        };
    }

    public fun turbos_swap_b_a<T0, T1, T2>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg1: vector<0x2::coin::Coin<T1>>, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg6: bool, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg7);
        if (arg6) {
            let v1 = 0x1::vector::pop_back<0x2::coin::Coin<T1>>(&mut arg1);
            let (v2, v3) = get_fee<T1>(&v1);
            let (v4, v5) = get_coin_fee<T1>(v1, v3, arg7);
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v5, @0x4b57068af6be5bb31ddbb70da8819856ea590f741a62cbe97ef4f80d47336875);
            0x1::vector::push_back<0x2::coin::Coin<T1>>(&mut arg1, v4);
            0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::swap_router::swap_b_a<T0, T1, T2>(arg0, arg1, v2, arg3, 79226673515401279992447579055, true, v0, 0x2::clock::timestamp_ms(arg4), arg4, arg5, arg7);
        } else {
            let (v6, v7) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::swap_router::swap_b_a_with_return_<T0, T1, T2>(arg0, arg1, arg2, arg3, 79226673515401279992447579055, true, v0, 0x2::clock::timestamp_ms(arg4), arg4, arg5, arg7);
            let v8 = v7;
            let v9 = v6;
            let (_, v11) = get_fee<T1>(&v8);
            let (v12, v13) = get_coin_fee<T1>(v8, v11, arg7);
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v12, v0);
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v13, @0x4b57068af6be5bb31ddbb70da8819856ea590f741a62cbe97ef4f80d47336875);
            if (0x2::coin::value<T0>(&v9) == 0) {
                0x2::coin::destroy_zero<T0>(v9);
            } else {
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v9, v0);
            };
        };
    }

    // decompiled from Move bytecode v6
}

