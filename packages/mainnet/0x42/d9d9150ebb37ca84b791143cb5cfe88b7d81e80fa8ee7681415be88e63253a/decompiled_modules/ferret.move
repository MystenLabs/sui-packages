module 0x42d9d9150ebb37ca84b791143cb5cfe88b7d81e80fa8ee7681415be88e63253a::ferret {
    struct ContractData has store, key {
        id: 0x2::object::UID,
    }

    struct AccessList has store, key {
        id: 0x2::object::UID,
        list: vector<address>,
    }

    public fun access_list_add(arg0: &mut AccessList, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == @0xaecdaa08f1b9f4469aa3abe357a0ec105152a9b72129245a2e3277c98e4f3914, 10000000000);
        0x1::vector::push_back<address>(&mut arg0.list, arg1);
    }

    public fun animeswap_0<T0, T1>(arg0: &mut AccessList, arg1: &mut 0x88d362329ede856f5f67867929ed570bba06c975abec2fab7f0601c56f6a8cb1::animeswap::LiquidityPools, arg2: &0x2::clock::Clock, arg3: 0x2::coin::Coin<T0>, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert!(is_valid(arg0, arg4), 10000000002);
        let (v0, v1) = 0x88d362329ede856f5f67867929ed570bba06c975abec2fab7f0601c56f6a8cb1::animeswap::swap_coins_for_coins<T0, T1>(arg1, arg2, arg3, 0x2::coin::zero<T1>(arg4), arg4);
        transfer_or_destroy_zero<T0>(v0, 0x2::tx_context::sender(arg4));
        v1
    }

    public fun animeswap_1<T0, T1>(arg0: &mut AccessList, arg1: &mut 0x88d362329ede856f5f67867929ed570bba06c975abec2fab7f0601c56f6a8cb1::animeswap::LiquidityPools, arg2: &0x2::clock::Clock, arg3: 0x2::coin::Coin<T1>, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(is_valid(arg0, arg4), 10000000002);
        let (v0, v1) = 0x88d362329ede856f5f67867929ed570bba06c975abec2fab7f0601c56f6a8cb1::animeswap::swap_coins_for_coins<T1, T0>(arg1, arg2, arg3, 0x2::coin::zero<T0>(arg4), arg4);
        transfer_or_destroy_zero<T1>(v0, 0x2::tx_context::sender(arg4));
        v1
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        new_access_list(arg0);
    }

    fun is_valid(arg0: &mut AccessList, arg1: &mut 0x2::tx_context::TxContext) : bool {
        let v0 = arg0.list;
        let v1 = 0x2::tx_context::sender(arg1);
        0x1::vector::contains<address>(&v0, &v1)
    }

    fun new_access_list(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::singleton<address>(@0xaecdaa08f1b9f4469aa3abe357a0ec105152a9b72129245a2e3277c98e4f3914);
        0x1::vector::push_back<address>(&mut v0, @0x6a2fdf6ed9df04787cab1478d57c97755764da30afd41b0aeea9141fafa984ac);
        0x1::vector::push_back<address>(&mut v0, @0xf060418a475679985421b63daad483218c6de2c051abf60d40974c656a5655ba);
        0x1::vector::push_back<address>(&mut v0, @0x9513af2fcc963b8396bdafc83610d125ec1e6330080bdabb3cf7fc7e0df9c84b);
        0x1::vector::push_back<address>(&mut v0, @0x83dbcc5cd37cd5a6e67b62c42ae746687424e1fa2900b160502e7e63638c5df7);
        let v1 = AccessList{
            id   : 0x2::object::new(arg0),
            list : v0,
        };
        0x2::transfer::share_object<AccessList>(v1);
    }

    public fun transfer_coins_with_threshold_2<T0>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<T0>(&arg0) >= arg1, 10000000001);
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

