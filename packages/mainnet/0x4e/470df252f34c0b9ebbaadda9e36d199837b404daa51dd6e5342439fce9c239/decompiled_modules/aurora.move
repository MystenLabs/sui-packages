module 0x4e470df252f34c0b9ebbaadda9e36d199837b404daa51dd6e5342439fce9c239::aurora {
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

    public fun cetuswap_0<T0, T1>(arg0: &mut AccessList, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &0x2::clock::Clock, arg4: 0x2::coin::Coin<T0>, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert!(is_valid(arg0, arg5), 1);
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg1, arg2, true, true, 0x2::coin::value<T0>(&arg4), 4295048016, arg3);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg1, arg2, 0x2::coin::into_balance<T0>(arg4), 0x2::balance::zero<T1>(), v2);
        0x2::balance::destroy_zero<T0>(v0);
        0x2::coin::from_balance<T1>(v1, arg5)
    }

    public fun cetuswap_1<T0, T1>(arg0: &mut AccessList, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &0x2::clock::Clock, arg4: 0x2::coin::Coin<T1>, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(is_valid(arg0, arg5), 1);
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg1, arg2, false, true, 0x2::coin::value<T1>(&arg4), 79226673515401279992447579055, arg3);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg1, arg2, 0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(arg4), v2);
        0x2::balance::destroy_zero<T1>(v1);
        0x2::coin::from_balance<T0>(v0, arg5)
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

