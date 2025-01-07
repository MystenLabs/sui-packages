module 0x1fd6a000d671a12d91ef8c8ba54fb5bd9886ac796c3961fb31b88f5278888943::ferret {
    struct ContractData has store, key {
        id: 0x2::object::UID,
    }

    struct AccessList has store, key {
        id: 0x2::object::UID,
        list: vector<address>,
    }

    public fun access_list_add(arg0: &mut AccessList, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == @0xaecdaa08f1b9f4469aa3abe357a0ec105152a9b72129245a2e3277c98e4f3914, 10000001);
        0x1::vector::push_back<address>(&mut arg0.list, arg1);
    }

    public fun access_list_remove(arg0: &mut AccessList, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == @0xaecdaa08f1b9f4469aa3abe357a0ec105152a9b72129245a2e3277c98e4f3914, 10000001);
        let (v0, v1) = 0x1::vector::index_of<address>(&mut arg0.list, &arg1);
        if (v0) {
            0x1::vector::remove<address>(&mut arg0.list, v1);
        };
    }

    public fun animeswap_0<T0, T1>(arg0: &mut AccessList, arg1: &mut 0x88d362329ede856f5f67867929ed570bba06c975abec2fab7f0601c56f6a8cb1::animeswap::LiquidityPools, arg2: &0x2::clock::Clock, arg3: vector<0x2::coin::Coin<T0>>, arg4: &mut 0x2::tx_context::TxContext) : vector<0x2::coin::Coin<T1>> {
        assert!(is_valid(arg0, arg4), 10000002);
        0x1::vector::destroy_empty<0x2::coin::Coin<T0>>(arg3);
        let (v0, v1) = 0x88d362329ede856f5f67867929ed570bba06c975abec2fab7f0601c56f6a8cb1::animeswap::swap_coins_for_coins<T0, T1>(arg1, arg2, 0x1::vector::pop_back<0x2::coin::Coin<T0>>(&mut arg3), 0x2::coin::zero<T1>(arg4), arg4);
        transfer_or_destroy_zero<T0>(v0, 0x2::tx_context::sender(arg4));
        0x1::vector::singleton<0x2::coin::Coin<T1>>(v1)
    }

    public fun animeswap_1<T0, T1>(arg0: &mut AccessList, arg1: &mut 0x88d362329ede856f5f67867929ed570bba06c975abec2fab7f0601c56f6a8cb1::animeswap::LiquidityPools, arg2: &0x2::clock::Clock, arg3: vector<0x2::coin::Coin<T1>>, arg4: &mut 0x2::tx_context::TxContext) : vector<0x2::coin::Coin<T0>> {
        assert!(is_valid(arg0, arg4), 10000002);
        0x1::vector::destroy_empty<0x2::coin::Coin<T1>>(arg3);
        let (v0, v1) = 0x88d362329ede856f5f67867929ed570bba06c975abec2fab7f0601c56f6a8cb1::animeswap::swap_coins_for_coins<T0, T1>(arg1, arg2, 0x2::coin::zero<T0>(arg4), 0x1::vector::pop_back<0x2::coin::Coin<T1>>(&mut arg3), arg4);
        transfer_or_destroy_zero<T1>(v1, 0x2::tx_context::sender(arg4));
        0x1::vector::singleton<0x2::coin::Coin<T0>>(v0)
    }

    public fun extract<T0>(arg0: &mut AccessList, arg1: &mut ContractData, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(is_valid(arg0, arg3), 10000002);
        0x2::coin::split<T0>(0x2::dynamic_object_field::borrow_mut<vector<u8>, 0x2::coin::Coin<T0>>(&mut arg1.id, b"coin"), arg2, arg3)
    }

    public fun extract2<T0>(arg0: &mut AccessList, arg1: &mut ContractData, arg2: u64, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(is_valid(arg0, arg4), 10000002);
        0x2::coin::split<T0>(0x2::dynamic_object_field::borrow_mut<vector<u8>, 0x2::coin::Coin<T0>>(&mut arg1.id, arg3), arg2, arg4)
    }

    public fun extract_then_transfer<T0>(arg0: &mut AccessList, arg1: &mut ContractData, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(is_valid(arg0, arg3), 10000002);
        transfer_or_destroy_zero<T0>(0x2::coin::split<T0>(0x2::dynamic_object_field::borrow_mut<vector<u8>, 0x2::coin::Coin<T0>>(&mut arg1.id, b"coin"), arg2, arg3), 0x2::tx_context::sender(arg3));
    }

    public fun extract_then_transfer2<T0>(arg0: &mut AccessList, arg1: &mut ContractData, arg2: u64, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(is_valid(arg0, arg4), 10000002);
        transfer_or_destroy_zero<T0>(0x2::coin::split<T0>(0x2::dynamic_object_field::borrow_mut<vector<u8>, 0x2::coin::Coin<T0>>(&mut arg1.id, arg3), arg2, arg4), 0x2::tx_context::sender(arg4));
    }

    public fun extract_vec<T0>(arg0: &mut AccessList, arg1: &mut ContractData, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : vector<0x2::coin::Coin<T0>> {
        assert!(is_valid(arg0, arg3), 10000002);
        0x1::vector::singleton<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(0x2::dynamic_object_field::borrow_mut<vector<u8>, 0x2::coin::Coin<T0>>(&mut arg1.id, b"coin"), arg2, arg3))
    }

    public fun extract_vec2<T0>(arg0: &mut AccessList, arg1: &mut ContractData, arg2: u64, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) : vector<0x2::coin::Coin<T0>> {
        assert!(is_valid(arg0, arg4), 10000002);
        0x1::vector::singleton<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(0x2::dynamic_object_field::borrow_mut<vector<u8>, 0x2::coin::Coin<T0>>(&mut arg1.id, arg3), arg2, arg4))
    }

    fun is_valid(arg0: &mut AccessList, arg1: &mut 0x2::tx_context::TxContext) : bool {
        let v0 = 0x2::tx_context::sender(arg1);
        0x1::vector::contains<address>(&mut arg0.list, &v0)
    }

    public fun new_access_list(arg0: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg0) == @0xaecdaa08f1b9f4469aa3abe357a0ec105152a9b72129245a2e3277c98e4f3914, 10000001);
        let v0 = AccessList{
            id   : 0x2::object::new(arg0),
            list : 0x1::vector::singleton<address>(@0xaecdaa08f1b9f4469aa3abe357a0ec105152a9b72129245a2e3277c98e4f3914),
        };
        0x2::transfer::share_object<AccessList>(v0);
    }

    public fun new_contract_data(arg0: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg0) == @0xaecdaa08f1b9f4469aa3abe357a0ec105152a9b72129245a2e3277c98e4f3914, 10000001);
        let v0 = ContractData{id: 0x2::object::new(arg0)};
        0x2::transfer::share_object<ContractData>(v0);
    }

    public fun return_vec<T0>(arg0: &mut ContractData, arg1: vector<0x2::coin::Coin<T0>>, arg2: &mut 0x2::tx_context::TxContext) {
        0x1::vector::destroy_empty<0x2::coin::Coin<T0>>(arg1);
        0x2::coin::put<T0>(0x2::coin::balance_mut<T0>(0x2::dynamic_object_field::borrow_mut<vector<u8>, 0x2::coin::Coin<T0>>(&mut arg0.id, b"coin")), 0x1::vector::pop_back<0x2::coin::Coin<T0>>(&mut arg1));
    }

    public fun return_vec2<T0>(arg0: &mut ContractData, arg1: vector<0x2::coin::Coin<T0>>, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        0x1::vector::destroy_empty<0x2::coin::Coin<T0>>(arg1);
        0x2::coin::put<T0>(0x2::coin::balance_mut<T0>(0x2::dynamic_object_field::borrow_mut<vector<u8>, 0x2::coin::Coin<T0>>(&mut arg0.id, arg2)), 0x1::vector::pop_back<0x2::coin::Coin<T0>>(&mut arg1));
    }

    public fun return_vec2_with_threshold<T0>(arg0: &mut ContractData, arg1: vector<0x2::coin::Coin<T0>>, arg2: vector<u8>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::pop_back<0x2::coin::Coin<T0>>(&mut arg1);
        assert!(0x2::coin::value<T0>(&v0) >= arg3, 10000000);
        0x1::vector::destroy_empty<0x2::coin::Coin<T0>>(arg1);
        0x2::coin::put<T0>(0x2::coin::balance_mut<T0>(0x2::dynamic_object_field::borrow_mut<vector<u8>, 0x2::coin::Coin<T0>>(&mut arg0.id, arg2)), v0);
    }

    public fun save<T0>(arg0: &mut ContractData, arg1: 0x2::coin::Coin<T0>, arg2: vector<u8>) {
        0x2::dynamic_object_field::add<vector<u8>, 0x2::coin::Coin<T0>>(&mut arg0.id, arg2, arg1);
    }

    public fun transfer_coins<T0>(arg0: vector<0x2::coin::Coin<T0>>, arg1: &mut 0x2::tx_context::TxContext) {
        0x1::vector::destroy_empty<0x2::coin::Coin<T0>>(arg0);
        transfer_or_destroy_zero<T0>(0x1::vector::pop_back<0x2::coin::Coin<T0>>(&mut arg0), 0x2::tx_context::sender(arg1));
    }

    public fun transfer_coins_with_threshold<T0>(arg0: vector<0x2::coin::Coin<T0>>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::pop_back<0x2::coin::Coin<T0>>(&mut arg0);
        assert!(0x2::coin::value<T0>(&v0) >= arg1, 10000000);
        0x1::vector::destroy_empty<0x2::coin::Coin<T0>>(arg0);
        transfer_or_destroy_zero<T0>(v0, 0x2::tx_context::sender(arg2));
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

