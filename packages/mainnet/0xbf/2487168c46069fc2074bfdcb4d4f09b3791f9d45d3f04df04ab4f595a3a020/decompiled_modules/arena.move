module 0x82eebf11a7d6c13c7b6edf5344cb262f61e4fe36ff3305482dce22f58b212224::arena {
    struct BetaUserCap has key {
        id: 0x2::object::UID,
    }

    struct BoutComplete has copy, drop {
        id: vector<u8>,
    }

    struct GemStash<phantom T0> has store, key {
        id: 0x2::object::UID,
        inventory: 0x2::balance::Balance<T0>,
        owner: address,
    }

    public fun battle_freya<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: 0x2::coin::Coin<T1>, arg2: bool, arg3: &mut 0x361dd589b98e8fcda9a7ee53b85efabef3569d00416640d2faa516e3801d7ffc::pool::Pool<T0, T1>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        if (arg2) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(arg1, 0x2::tx_context::sender(arg5));
            0x361dd589b98e8fcda9a7ee53b85efabef3569d00416640d2faa516e3801d7ffc::pool::do_swap_x_to_y_direct<T0, T1>(arg3, 0x1::vector::singleton<0x2::coin::Coin<T0>>(arg0), place_wager<T0, T1>(arg2, &arg0, &arg1), arg4, arg5)
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, 0x2::tx_context::sender(arg5));
            let (v2, v3) = 0x361dd589b98e8fcda9a7ee53b85efabef3569d00416640d2faa516e3801d7ffc::pool::do_swap_y_to_x_direct<T0, T1>(arg3, 0x1::vector::singleton<0x2::coin::Coin<T1>>(arg1), place_wager<T0, T1>(arg2, &arg0, &arg1), arg4, arg5);
            (v3, v2)
        }
    }

    public fun battle_hel<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: 0x2::coin::Coin<T1>, arg2: bool, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let v0 = if (arg2) {
            4295048016
        } else {
            79226673515401279992447579055
        };
        let (v1, v2, v3) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg3, arg4, arg2, true, place_wager<T0, T1>(arg2, &arg0, &arg1), v0, arg5);
        let v4 = v3;
        let v5 = v2;
        let v6 = v1;
        if (arg2) {
        };
        let (v7, v8) = if (arg2) {
            (0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg0, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v4), arg6)), 0x2::balance::zero<T1>())
        } else {
            (0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut arg1, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v4), arg6)))
        };
        0x2::coin::join<T1>(&mut arg1, 0x2::coin::from_balance<T1>(v5, arg6));
        0x2::coin::join<T0>(&mut arg0, 0x2::coin::from_balance<T0>(v6, arg6));
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg3, arg4, v7, v8, v4);
        (arg0, arg1)
    }

    public fun battle_modi<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: 0x2::coin::Coin<T1>, arg2: bool, arg3: &mut 0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::stable_swap::Dex_Stable_Info, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        if (arg2) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(arg1, 0x2::tx_context::sender(arg5));
            (0x2::coin::zero<T0>(arg5), 0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::stable_router::swap_exact_input_<T0, T1>(arg0, place_wager<T0, T1>(arg2, &arg0, &arg1), 0, arg3, arg4, arg5))
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, 0x2::tx_context::sender(arg5));
            (0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::stable_router::swap_exact_input_<T1, T0>(arg1, place_wager<T0, T1>(arg2, &arg0, &arg1), 0, arg3, arg4, arg5), 0x2::coin::zero<T1>(arg5))
        }
    }

    public fun battle_thor<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: 0x2::coin::Coin<T1>, arg2: bool, arg3: &mut 0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::swap::Dex_Info, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        if (arg2) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(arg1, 0x2::tx_context::sender(arg4));
            (0x2::coin::zero<T0>(arg4), 0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::router::swap_exact_input_<T0, T1>(place_wager<T0, T1>(arg2, &arg0, &arg1), arg0, 0, arg3, arg4))
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, 0x2::tx_context::sender(arg4));
            (0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::router::swap_exact_input_<T1, T0>(place_wager<T0, T1>(arg2, &arg0, &arg1), arg1, 0, arg3, arg4), 0x2::coin::zero<T1>(arg4))
        }
    }

    entry fun create_empty_stash<T0>(arg0: &BetaUserCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = GemStash<T0>{
            id        : 0x2::object::new(arg1),
            inventory : 0x2::balance::zero<T0>(),
            owner     : 0x2::tx_context::sender(arg1),
        };
        0x2::transfer::share_object<GemStash<T0>>(v0);
    }

    entry fun deposit_gems<T0>(arg0: &mut GemStash<T0>, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<T0>(&arg1) >= arg2, 2);
        0x2::balance::join<T0>(&mut arg0.inventory, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg1, arg2, arg3)));
        transfer_or_destroy_zero<T0>(arg1, 0x2::tx_context::sender(arg3));
    }

    public fun end_bout<T0>(arg0: &mut GemStash<T0>, arg1: u64, arg2: 0x2::coin::Coin<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<T0>(&arg2) > arg1, 4);
        let v0 = 0x2::bcs::to_bytes<u64>(&arg1);
        let v1 = 0x2::coin::value<T0>(&arg2);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&v1));
        let v2 = BoutComplete{id: v0};
        0x2::event::emit<BoutComplete>(v2);
        0x2::balance::join<T0>(&mut arg0.inventory, 0x2::coin::into_balance<T0>(arg2));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = BetaUserCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<BetaUserCap>(v0, 0x2::tx_context::sender(arg0));
    }

    fun place_wager<T0, T1>(arg0: bool, arg1: &0x2::coin::Coin<T0>, arg2: &0x2::coin::Coin<T1>) : u64 {
        if (arg0) {
            assert!(0x2::coin::value<T1>(arg2) == 0, 0);
            0x2::coin::value<T0>(arg1)
        } else {
            assert!(0x2::coin::value<T0>(arg1) == 0, 0);
            0x2::coin::value<T1>(arg2)
        }
    }

    public fun start_bout<T0>(arg0: &mut GemStash<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 1);
        assert!(0x2::balance::value<T0>(&arg0.inventory) >= arg1, 3);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.inventory, arg1), arg2)
    }

    fun transfer_or_destroy_zero<T0>(arg0: 0x2::coin::Coin<T0>, arg1: address) {
        if (0x2::coin::value<T0>(&arg0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, arg1);
        } else {
            0x2::coin::destroy_zero<T0>(arg0);
        };
    }

    entry fun withdraw_gems<T0>(arg0: &mut GemStash<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = withdraw_gems_internal<T0>(arg0, arg1, arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, 0x2::tx_context::sender(arg2));
    }

    fun withdraw_gems_internal<T0>(arg0: &mut GemStash<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 1);
        assert!(0x2::balance::value<T0>(&arg0.inventory) >= arg1, 3);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.inventory, arg1), arg2)
    }

    // decompiled from Move bytecode v6
}

