module 0x5b5ee49588462cd3d41a5fa5058f186823b339e769c5d5cef5a3114138af98d6::aurora {
    struct ContractData has store, key {
        id: 0x2::object::UID,
    }

    struct AccessList has store, key {
        id: 0x2::object::UID,
        list: vector<address>,
    }

    public fun access_list_add(arg0: &mut AccessList, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == @0x87c9e076815e78ee63b7dc225704c428b8c51072ccead4304ae07f6c68fe1b92, 1);
        0x1::vector::push_back<address>(&mut arg0.list, arg1);
    }

    public fun c0<T0, T1>(arg0: &mut 0xe016516cae4c27eb871870e3b1dd63d45ae180c412677784915b437a7ec930f0::safeV2::AccessList, arg1: &mut 0xe016516cae4c27eb871870e3b1dd63d45ae180c412677784915b437a7ec930f0::safeV2::Pool<T0>, arg2: &mut 0xe016516cae4c27eb871870e3b1dd63d45ae180c412677784915b437a7ec930f0::safeV2::Pool<T1>, arg3: u64, arg4: u64, arg5: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg7: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::partner::Partner, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap_with_partner<T1, T0>(arg5, arg6, arg7, false, true, arg3, 79226673515401279992447579055, arg8);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap_with_partner<T1, T0>(arg5, arg6, arg7, 0x2::balance::zero<T1>(), 0x2::coin::into_balance<T0>(0xe016516cae4c27eb871870e3b1dd63d45ae180c412677784915b437a7ec930f0::safeV2::withdraw<T0>(arg0, arg1, arg3, arg9)), v2);
        0x2::balance::destroy_zero<T0>(v1);
        0xe016516cae4c27eb871870e3b1dd63d45ae180c412677784915b437a7ec930f0::safeV2::deposit<T1>(arg2, 0x2::coin::from_balance<T1>(v0, arg9), arg4, arg9);
    }

    public fun c1_to<T0, T1>(arg0: &mut 0xe016516cae4c27eb871870e3b1dd63d45ae180c412677784915b437a7ec930f0::safeV2::AccessList, arg1: &mut 0xe016516cae4c27eb871870e3b1dd63d45ae180c412677784915b437a7ec930f0::safeV2::Pool<T0>, arg2: &mut 0xe016516cae4c27eb871870e3b1dd63d45ae180c412677784915b437a7ec930f0::safeV2::Pool<T1>, arg3: u64, arg4: u64, arg5: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg7: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::partner::Partner, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap_with_partner<T0, T1>(arg5, arg6, arg7, true, false, arg4, 79226673515401279992447579055, arg8);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap_with_partner<T0, T1>(arg5, arg6, arg7, 0x2::coin::into_balance<T0>(0xe016516cae4c27eb871870e3b1dd63d45ae180c412677784915b437a7ec930f0::safeV2::withdraw<T0>(arg0, arg1, arg3, arg9)), 0x2::balance::zero<T1>(), v2);
        let v3 = 0x2::coin::from_balance<T0>(v0, arg9);
        if (0x2::coin::value<T0>(&v3) > 0) {
            0xe016516cae4c27eb871870e3b1dd63d45ae180c412677784915b437a7ec930f0::safeV2::deposit<T0>(arg1, v3, 0, arg9);
        } else {
            0x2::coin::destroy_zero<T0>(v3);
        };
        0xe016516cae4c27eb871870e3b1dd63d45ae180c412677784915b437a7ec930f0::safeV2::deposit<T1>(arg2, 0x2::coin::from_balance<T1>(v1, arg9), arg4, arg9);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        new_access_list(arg0);
    }

    fun is_valid(arg0: &AccessList, arg1: &0x2::tx_context::TxContext) : bool {
        let v0 = arg0.list;
        let v1 = 0x2::tx_context::sender(arg1);
        0x1::vector::contains<address>(&v0, &v1)
    }

    fun new_access_list(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AccessList{
            id   : 0x2::object::new(arg0),
            list : 0x1::vector::singleton<address>(@0x87c9e076815e78ee63b7dc225704c428b8c51072ccead4304ae07f6c68fe1b92),
        };
        0x2::transfer::share_object<AccessList>(v0);
    }

    public fun transfer_coins_with_threshold<T0>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<T0>(&arg0) >= arg1, 2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, 0x2::tx_context::sender(arg2));
    }

    fun transfer_or_destroy_zero<T0>(arg0: 0x2::coin::Coin<T0>, arg1: address) {
        if (0x2::coin::value<T0>(&arg0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, arg1);
        } else {
            0x2::coin::destroy_zero<T0>(arg0);
        };
    }

    // decompiled from Move bytecode v6
}

