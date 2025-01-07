module 0x42a191002aa2e1a9d1d7a18427be7493fd28326a306ebdf03d7b5ff79c719ac9::x_contract {
    struct AccessList has store, key {
        id: 0x2::object::UID,
        list: vector<address>,
    }

    public fun access_list_add(arg0: &mut AccessList, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == @0x53e7318a2975de79509359aa970c52c820f19225252e5375e7e20b5bca12e05f, 10000000000);
        0x1::vector::push_back<address>(&mut arg0.list, arg1);
    }

    public fun access_list_add_vec(arg0: &mut AccessList, arg1: vector<address>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == @0x53e7318a2975de79509359aa970c52c820f19225252e5375e7e20b5bca12e05f, 10000000000);
        0x1::vector::append<address>(&mut arg0.list, arg1);
    }

    public fun cetuswap_0<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &0x2::clock::Clock, arg3: 0x2::coin::Coin<T0>, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, true, true, 0x2::coin::value<T0>(&arg3), 4295048016, arg2);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(arg3), 0x2::balance::zero<T1>(), v2);
        0x2::balance::destroy_zero<T0>(v0);
        0x2::coin::from_balance<T1>(v1, arg4)
    }

    public fun cetuswap_1<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &0x2::clock::Clock, arg3: 0x2::coin::Coin<T1>, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, false, true, 0x2::coin::value<T1>(&arg3), 79226673515401279992447579055, arg2);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(arg3), v2);
        0x2::balance::destroy_zero<T1>(v1);
        0x2::coin::from_balance<T0>(v0, arg4)
    }

    public fun hello_world() : 0x1::string::String {
        0x1::string::utf8(b"Hello, World!")
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
            list : 0x1::vector::singleton<address>(@0x53e7318a2975de79509359aa970c52c820f19225252e5375e7e20b5bca12e05f),
        };
        0x2::transfer::share_object<AccessList>(v0);
    }

    public fun transfer_coins_with_threshold_2<T0>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<T0>(&arg0) >= arg1, 10000000001);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

