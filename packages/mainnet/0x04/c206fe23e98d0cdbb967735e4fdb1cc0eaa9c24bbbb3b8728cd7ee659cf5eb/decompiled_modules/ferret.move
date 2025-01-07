module 0x4c206fe23e98d0cdbb967735e4fdb1cc0eaa9c24bbbb3b8728cd7ee659cf5eb::ferret {
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

    public fun bluemoveswap_0<T0, T1>(arg0: &mut AccessList, arg1: &mut 0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::swap::Dex_Info, arg2: vector<0x2::coin::Coin<T0>>, arg3: &mut 0x2::tx_context::TxContext) : vector<0x2::coin::Coin<T1>> {
        assert!(is_valid(arg0, arg3), 10000002);
        let v0 = 0x1::vector::pop_back<0x2::coin::Coin<T0>>(&mut arg2);
        0x1::vector::destroy_empty<0x2::coin::Coin<T0>>(arg2);
        0x1::vector::singleton<0x2::coin::Coin<T1>>(0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::router::swap_exact_input_<T0, T1>(0x2::coin::value<T0>(&v0), v0, 0, arg1, arg3))
    }

    public fun bluemoveswap_1<T0, T1>(arg0: &mut AccessList, arg1: &mut 0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::swap::Dex_Info, arg2: vector<0x2::coin::Coin<T1>>, arg3: &mut 0x2::tx_context::TxContext) : vector<0x2::coin::Coin<T0>> {
        assert!(is_valid(arg0, arg3), 10000002);
        let v0 = 0x1::vector::pop_back<0x2::coin::Coin<T1>>(&mut arg2);
        0x1::vector::destroy_empty<0x2::coin::Coin<T1>>(arg2);
        0x1::vector::singleton<0x2::coin::Coin<T0>>(0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::router::swap_exact_input_<T1, T0>(0x2::coin::value<T1>(&v0), v0, 0, arg1, arg3))
    }

    public fun cetuswap_0<T0, T1>(arg0: &mut AccessList, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: vector<0x2::coin::Coin<T0>>, arg4: bool, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : vector<0x2::coin::Coin<T1>> {
        assert!(is_valid(arg0, arg6), 10000002);
        let v0 = 0x1::vector::pop_back<0x2::coin::Coin<T0>>(&mut arg3);
        0x1::vector::destroy_empty<0x2::coin::Coin<T0>>(arg3);
        let v1 = 0x2::coin::zero<T1>(arg6);
        let (v2, v3) = cetuswap_agent<T0, T1>(arg1, arg2, v0, v1, true, arg4, 0x2::coin::value<T0>(&v0), 340282366920938463463374607431768211445, arg5, arg6);
        transfer_or_destroy_zero<T0>(v2, 0x2::tx_context::sender(arg6));
        0x1::vector::singleton<0x2::coin::Coin<T1>>(v3)
    }

    public fun cetuswap_1<T0, T1>(arg0: &mut AccessList, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: vector<0x2::coin::Coin<T1>>, arg4: bool, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : vector<0x2::coin::Coin<T0>> {
        assert!(is_valid(arg0, arg6), 10000002);
        let v0 = 0x1::vector::pop_back<0x2::coin::Coin<T1>>(&mut arg3);
        0x1::vector::destroy_empty<0x2::coin::Coin<T1>>(arg3);
        let v1 = 0x2::coin::zero<T0>(arg6);
        let (v2, v3) = cetuswap_agent<T0, T1>(arg1, arg2, v1, v0, false, arg4, 0x2::coin::value<T1>(&v0), 340282366920938463463374607431768211445, arg5, arg6);
        transfer_or_destroy_zero<T1>(v3, 0x2::tx_context::sender(arg6));
        0x1::vector::singleton<0x2::coin::Coin<T0>>(v2)
    }

    fun cetuswap_agent<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::coin::Coin<T1>, arg4: bool, arg5: bool, arg6: u64, arg7: u128, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, arg4, arg5, arg6, arg7, arg8);
        let v3 = v2;
        let (v4, v5) = if (arg4) {
            (0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg2, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v3), arg9)), 0x2::balance::zero<T1>())
        } else {
            (0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut arg3, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v3), arg9)))
        };
        0x2::coin::join<T1>(&mut arg3, 0x2::coin::from_balance<T1>(v1, arg9));
        0x2::coin::join<T0>(&mut arg2, 0x2::coin::from_balance<T0>(v0, arg9));
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, v4, v5, v3);
        (arg2, arg3)
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

    public fun jujubeswap_0<T0, T1>(arg0: &mut AccessList, arg1: &mut 0xf435e16e002dd0cbe7afe9a449498ae5f589712365cad41ad0854a9cec5487e2::liquidity_pool::SwapInfo, arg2: &mut 0xf435e16e002dd0cbe7afe9a449498ae5f589712365cad41ad0854a9cec5487e2::dao_storage::DaoStorageInfo, arg3: &0x2::clock::Clock, arg4: vector<0x2::coin::Coin<T0>>, arg5: &mut 0x2::tx_context::TxContext) : vector<0x2::coin::Coin<T1>> {
        assert!(is_valid(arg0, arg5), 10000002);
        let v0 = 0x1::vector::pop_back<0x2::coin::Coin<T0>>(&mut arg4);
        0x1::vector::destroy_empty<0x2::coin::Coin<T0>>(arg4);
        let (v1, v2) = 0xf435e16e002dd0cbe7afe9a449498ae5f589712365cad41ad0854a9cec5487e2::router::get_reserves_size<T0, T1>(arg1);
        let (v3, v4) = 0xf435e16e002dd0cbe7afe9a449498ae5f589712365cad41ad0854a9cec5487e2::router::get_fees_config<T0, T1>(arg1);
        let (v5, v6) = 0xf435e16e002dd0cbe7afe9a449498ae5f589712365cad41ad0854a9cec5487e2::liquidity_pool::swap<T0, T1>(arg1, arg2, arg3, v0, 0, 0x2::coin::zero<T1>(arg5), 0xf435e16e002dd0cbe7afe9a449498ae5f589712365cad41ad0854a9cec5487e2::router::get_amount_out<T0, T1>(v1, v2, v3, v4, 0x2::coin::value<T0>(&v0)), arg5);
        0x2::coin::destroy_zero<T0>(v5);
        0x1::vector::singleton<0x2::coin::Coin<T1>>(v6)
    }

    public fun jujubeswap_1<T0, T1>(arg0: &mut AccessList, arg1: &mut 0xf435e16e002dd0cbe7afe9a449498ae5f589712365cad41ad0854a9cec5487e2::liquidity_pool::SwapInfo, arg2: &mut 0xf435e16e002dd0cbe7afe9a449498ae5f589712365cad41ad0854a9cec5487e2::dao_storage::DaoStorageInfo, arg3: &0x2::clock::Clock, arg4: vector<0x2::coin::Coin<T1>>, arg5: &mut 0x2::tx_context::TxContext) : vector<0x2::coin::Coin<T0>> {
        assert!(is_valid(arg0, arg5), 10000002);
        let v0 = 0x1::vector::pop_back<0x2::coin::Coin<T1>>(&mut arg4);
        0x1::vector::destroy_empty<0x2::coin::Coin<T1>>(arg4);
        let (v1, v2) = 0xf435e16e002dd0cbe7afe9a449498ae5f589712365cad41ad0854a9cec5487e2::router::get_reserves_size<T1, T0>(arg1);
        let (v3, v4) = 0xf435e16e002dd0cbe7afe9a449498ae5f589712365cad41ad0854a9cec5487e2::router::get_fees_config<T1, T0>(arg1);
        let (v5, v6) = 0xf435e16e002dd0cbe7afe9a449498ae5f589712365cad41ad0854a9cec5487e2::liquidity_pool::swap<T0, T1>(arg1, arg2, arg3, 0x2::coin::zero<T0>(arg5), 0xf435e16e002dd0cbe7afe9a449498ae5f589712365cad41ad0854a9cec5487e2::router::get_amount_out<T1, T0>(v1, v2, v3, v4, 0x2::coin::value<T1>(&v0)), v0, 0, arg5);
        0x2::coin::destroy_zero<T1>(v6);
        0x1::vector::singleton<0x2::coin::Coin<T0>>(v5)
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

    public fun unknownswap_0<T0, T1>(arg0: &mut AccessList, arg1: &mut 0xd842eddc81c64fb889aa1676068176f41b577b20c2d143c7b718f2ad1ebd56b2::swap::RyuSwap, arg2: &mut 0xd842eddc81c64fb889aa1676068176f41b577b20c2d143c7b718f2ad1ebd56b2::dao_fee::DaoFeeInfo, arg3: &0x2::clock::Clock, arg4: vector<0x2::coin::Coin<T0>>, arg5: &mut 0x2::tx_context::TxContext) : vector<0x2::coin::Coin<T1>> {
        assert!(is_valid(arg0, arg5), 10000002);
        let v0 = 0x1::vector::pop_back<0x2::coin::Coin<T0>>(&mut arg4);
        0x1::vector::destroy_empty<0x2::coin::Coin<T0>>(arg4);
        let (v1, v2) = 0xd842eddc81c64fb889aa1676068176f41b577b20c2d143c7b718f2ad1ebd56b2::router::get_reserves_size<T0, T1>(arg1);
        let (v3, v4) = 0xd842eddc81c64fb889aa1676068176f41b577b20c2d143c7b718f2ad1ebd56b2::router::get_fees_config<T0, T1>(arg1);
        let (v5, v6) = 0xd842eddc81c64fb889aa1676068176f41b577b20c2d143c7b718f2ad1ebd56b2::swap::swap<T0, T1>(arg1, arg2, arg3, v0, 0, 0x2::coin::zero<T1>(arg5), 0xd842eddc81c64fb889aa1676068176f41b577b20c2d143c7b718f2ad1ebd56b2::router::get_amount_out<T0, T1>(v1, v2, v3, v4, 0x2::coin::value<T0>(&v0)), arg5);
        0x2::coin::destroy_zero<T0>(v5);
        0x1::vector::singleton<0x2::coin::Coin<T1>>(v6)
    }

    public fun unknownswap_1<T0, T1>(arg0: &mut AccessList, arg1: &mut 0xd842eddc81c64fb889aa1676068176f41b577b20c2d143c7b718f2ad1ebd56b2::swap::RyuSwap, arg2: &mut 0xd842eddc81c64fb889aa1676068176f41b577b20c2d143c7b718f2ad1ebd56b2::dao_fee::DaoFeeInfo, arg3: &0x2::clock::Clock, arg4: vector<0x2::coin::Coin<T1>>, arg5: &mut 0x2::tx_context::TxContext) : vector<0x2::coin::Coin<T0>> {
        assert!(is_valid(arg0, arg5), 10000002);
        let v0 = 0x1::vector::pop_back<0x2::coin::Coin<T1>>(&mut arg4);
        0x1::vector::destroy_empty<0x2::coin::Coin<T1>>(arg4);
        let (v1, v2) = 0xd842eddc81c64fb889aa1676068176f41b577b20c2d143c7b718f2ad1ebd56b2::router::get_reserves_size<T1, T0>(arg1);
        let (v3, v4) = 0xd842eddc81c64fb889aa1676068176f41b577b20c2d143c7b718f2ad1ebd56b2::router::get_fees_config<T1, T0>(arg1);
        let (v5, v6) = 0xd842eddc81c64fb889aa1676068176f41b577b20c2d143c7b718f2ad1ebd56b2::swap::swap<T0, T1>(arg1, arg2, arg3, 0x2::coin::zero<T0>(arg5), 0xd842eddc81c64fb889aa1676068176f41b577b20c2d143c7b718f2ad1ebd56b2::router::get_amount_out<T1, T0>(v1, v2, v3, v4, 0x2::coin::value<T1>(&v0)), v0, 0, arg5);
        0x2::coin::destroy_zero<T1>(v6);
        0x1::vector::singleton<0x2::coin::Coin<T0>>(v5)
    }

    // decompiled from Move bytecode v6
}

