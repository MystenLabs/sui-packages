module 0x5fe9d2a1e28543e303c147f25ea32604c151973fef655347fbbc1ba364a9082a::router {
    public fun close_position<T0, T1>(arg0: &mut 0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::pool::Pool<T0, T1>, arg1: 0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::position::Position, arg2: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg3: vector<u32>, arg4: u64, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let v0 = &mut arg1;
        let (v1, v2) = remove_liquidity_all<T0, T1>(arg0, v0, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
        0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::pool::close_position<T0, T1>(arg0, arg1);
        (v1, v2)
    }

    fun check_deadline(arg0: &0x2::clock::Clock, arg1: u64) {
        assert!(arg1 <= 4102444800000, 908);
        assert!(0x2::clock::timestamp_ms(arg0) <= arg1, 902);
    }

    public fun close_position_x_sui<T0>(arg0: &mut 0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::pool::Pool<0x2::sui::SUI, T0>, arg1: 0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::position::Position, arg2: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg3: vector<u32>, arg4: &mut 0x3::sui_system::SuiSystemState, arg5: u64, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<T0>) {
        let v0 = &mut arg1;
        let (v1, v2) = remove_liquidity_all_x_sui<T0>(arg0, v0, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
        0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::pool::close_position<0x2::sui::SUI, T0>(arg0, arg1);
        (v1, v2)
    }

    fun finish_swap<T0, T1>(arg0: &mut 0x2::coin::Coin<T0>, arg1: 0x2::balance::Balance<T0>, arg2: 0x2::balance::Balance<T1>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x2::coin::join<T0>(arg0, 0x2::coin::from_balance<T0>(arg1, arg3));
        0x2::coin::from_balance<T1>(arg2, arg3)
    }

    fun full_position_shares(arg0: &0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::position::Position, arg1: &vector<u32>) : vector<u128> {
        let v0 = 0x1::vector::length<u32>(arg1);
        assert!(v0 == 0x1::vector::length<u32>(0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::position::bin_ids(arg0)), 912);
        let v1 = vector[];
        let v2 = 0;
        while (v2 < v0) {
            let v3 = *0x1::vector::borrow<u32>(arg1, v2);
            assert!(0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::position::has_bin(arg0, v3), 912);
            if (v2 > 0) {
                assert!(*0x1::vector::borrow<u32>(arg1, v2 - 1) < v3, 912);
            };
            0x1::vector::push_back<u128>(&mut v1, 0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::position::shares_in_bin(arg0, v3));
            v2 = v2 + 1;
        };
        v1
    }

    public fun max_deadline_ms() : u64 {
        4102444800000
    }

    fun min_out_from_slippage(arg0: u64, arg1: u64) : u64 {
        assert!(arg1 < 10000, 909);
        assert!(arg0 > 0, 900);
        let v0 = (0x577c62ef50b3e5780b988024c58c3c31528c89435bb0614aebed4b309ac8c7a2::u128_math::mul_div_floor((arg0 as u128), ((10000 - arg1) as u128), (10000 as u128)) as u64);
        if (v0 == 0) {
            1
        } else {
            v0
        }
    }

    fun prepare_exact_in<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, u64) {
        check_deadline(arg5, arg4);
        assert!(arg1 > 0, 900);
        (0x2::coin::into_balance<T0>(0x2::coin::split<T0>(arg0, arg1, arg6)), min_out_from_slippage(arg2, arg3))
    }

    fun prepare_exact_out<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: u64, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        check_deadline(arg4, arg3);
        assert!(arg2 > 0, 900);
        assert!(arg1 > 0, 900);
        0x2::coin::into_balance<T0>(0x2::coin::split<T0>(arg0, arg2, arg5))
    }

    public fun remove_liquidity_all<T0, T1>(arg0: &mut 0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::pool::Pool<T0, T1>, arg1: &mut 0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::position::Position, arg2: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg3: vector<u32>, arg4: u64, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        check_deadline(arg7, arg6);
        0x577c62ef50b3e5780b988024c58c3c31528c89435bb0614aebed4b309ac8c7a2::vec_sort::sort_u32(&mut arg3);
        if (0x1::vector::length<u32>(&arg3) == 0) {
            assert!(arg4 == 0 && arg5 == 0, 911);
            return (0x2::coin::zero<T0>(arg8), 0x2::coin::zero<T1>(arg8))
        };
        0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::pool::remove_liquidity<T0, T1>(arg0, arg1, arg2, arg3, full_position_shares(arg1, &arg3), arg4, arg5, arg6, arg7, arg8)
    }

    public fun remove_liquidity_all_x_sui<T0>(arg0: &mut 0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::pool::Pool<0x2::sui::SUI, T0>, arg1: &mut 0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::position::Position, arg2: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg3: vector<u32>, arg4: &mut 0x3::sui_system::SuiSystemState, arg5: u64, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<T0>) {
        check_deadline(arg8, arg7);
        0x577c62ef50b3e5780b988024c58c3c31528c89435bb0614aebed4b309ac8c7a2::vec_sort::sort_u32(&mut arg3);
        if (0x1::vector::length<u32>(&arg3) == 0) {
            assert!(arg5 == 0 && arg6 == 0, 911);
            return (0x2::coin::zero<0x2::sui::SUI>(arg9), 0x2::coin::zero<T0>(arg9))
        };
        0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::pool::remove_liquidity_x_sui<T0>(arg0, arg1, arg2, arg3, full_position_shares(arg1, &arg3), arg4, arg5, arg6, arg7, arg8, arg9)
    }

    public fun swap_exact_x_for_y<T0, T1>(arg0: &mut 0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::pool::Pool<T0, T1>, arg1: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg2: &mut 0x2::coin::Coin<T0>, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let (v0, v1) = prepare_exact_in<T0>(arg2, arg3, arg5, arg6, arg7, arg8, arg9);
        let (v2, v3) = 0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::pool::swap<T0, T1>(arg0, arg1, v0, 0x2::balance::zero<T1>(), true, true, arg3, v1, 0x1::option::some<u64>(arg4), 0x1::option::none<u32>(), arg8, arg9);
        finish_swap<T0, T1>(arg2, v2, v3, arg9)
    }

    public fun swap_exact_x_for_y_no_lending<T0, T1>(arg0: &mut 0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::pool::Pool<T0, T1>, arg1: &mut 0x2::coin::Coin<T0>, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let (v0, v1) = prepare_exact_in<T0>(arg1, arg2, arg4, arg5, arg6, arg7, arg8);
        let (v2, v3) = 0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::pool::swap_no_lending<T0, T1>(arg0, v0, 0x2::balance::zero<T1>(), true, true, arg2, v1, 0x1::option::some<u64>(arg3), 0x1::option::none<u32>(), arg7, arg8);
        finish_swap<T0, T1>(arg1, v2, v3, arg8)
    }

    public fun swap_exact_x_for_y_with_partner<T0, T1>(arg0: &mut 0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::pool::Pool<T0, T1>, arg1: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg2: &mut 0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::partner::Partner, arg3: &mut 0x2::coin::Coin<T0>, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert!(0x2::coin::value<T0>(arg3) >= arg4, 910);
        let (v0, v1) = prepare_exact_in<T0>(arg3, arg4, arg6, arg7, arg8, arg9, arg10);
        let (v2, v3) = 0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::pool::swap_with_partner<T0, T1>(arg0, arg1, arg2, v0, 0x2::balance::zero<T1>(), true, true, arg4, v1, 0x1::option::some<u64>(arg5), 0x1::option::none<u32>(), arg9, arg10);
        finish_swap<T0, T1>(arg3, v2, v3, arg10)
    }

    public fun swap_exact_x_for_y_with_partner_no_lending<T0, T1>(arg0: &mut 0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::pool::Pool<T0, T1>, arg1: &mut 0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::partner::Partner, arg2: &mut 0x2::coin::Coin<T0>, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert!(0x2::coin::value<T0>(arg2) >= arg3, 910);
        let (v0, v1) = prepare_exact_in<T0>(arg2, arg3, arg5, arg6, arg7, arg8, arg9);
        let (v2, v3) = 0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::pool::swap_with_partner_no_lending<T0, T1>(arg0, arg1, v0, 0x2::balance::zero<T1>(), true, true, arg3, v1, 0x1::option::some<u64>(arg4), 0x1::option::none<u32>(), arg8, arg9);
        finish_swap<T0, T1>(arg2, v2, v3, arg9)
    }

    public fun swap_exact_y_for_sui<T0>(arg0: &mut 0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::pool::Pool<0x2::sui::SUI, T0>, arg1: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg2: &mut 0x2::coin::Coin<T0>, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: &mut 0x3::sui_system::SuiSystemState, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        let (v0, v1) = prepare_exact_in<T0>(arg2, arg3, arg5, arg6, arg7, arg9, arg10);
        let (v2, v3) = 0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::pool::swap_sui_x<T0>(arg0, arg1, arg8, 0x2::balance::zero<0x2::sui::SUI>(), v0, false, true, arg3, v1, 0x1::option::some<u64>(arg4), 0x1::option::none<u32>(), arg9, arg10);
        finish_swap<T0, 0x2::sui::SUI>(arg2, v3, v2, arg10)
    }

    public fun swap_exact_y_for_sui_no_lending<T0>(arg0: &mut 0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::pool::Pool<0x2::sui::SUI, T0>, arg1: &mut 0x2::coin::Coin<T0>, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        let (v0, v1) = prepare_exact_in<T0>(arg1, arg2, arg4, arg5, arg6, arg7, arg8);
        let (v2, v3) = 0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::pool::swap_no_lending<0x2::sui::SUI, T0>(arg0, 0x2::balance::zero<0x2::sui::SUI>(), v0, false, true, arg2, v1, 0x1::option::some<u64>(arg3), 0x1::option::none<u32>(), arg7, arg8);
        finish_swap<T0, 0x2::sui::SUI>(arg1, v3, v2, arg8)
    }

    public fun swap_exact_y_for_sui_with_partner<T0>(arg0: &mut 0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::pool::Pool<0x2::sui::SUI, T0>, arg1: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg2: &mut 0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::partner::Partner, arg3: &mut 0x2::coin::Coin<T0>, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: &mut 0x3::sui_system::SuiSystemState, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert!(0x2::coin::value<T0>(arg3) >= arg4, 910);
        let (v0, v1) = prepare_exact_in<T0>(arg3, arg4, arg6, arg7, arg8, arg10, arg11);
        let (v2, v3) = 0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::pool::swap_sui_x_with_partner<T0>(arg0, arg1, arg2, arg9, 0x2::balance::zero<0x2::sui::SUI>(), v0, false, true, arg4, v1, 0x1::option::some<u64>(arg5), 0x1::option::none<u32>(), arg10, arg11);
        finish_swap<T0, 0x2::sui::SUI>(arg3, v3, v2, arg11)
    }

    public fun swap_exact_y_for_sui_with_partner_no_lending<T0>(arg0: &mut 0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::pool::Pool<0x2::sui::SUI, T0>, arg1: &mut 0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::partner::Partner, arg2: &mut 0x2::coin::Coin<T0>, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert!(0x2::coin::value<T0>(arg2) >= arg3, 910);
        let (v0, v1) = prepare_exact_in<T0>(arg2, arg3, arg5, arg6, arg7, arg8, arg9);
        let (v2, v3) = 0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::pool::swap_with_partner_no_lending<0x2::sui::SUI, T0>(arg0, arg1, 0x2::balance::zero<0x2::sui::SUI>(), v0, false, true, arg3, v1, 0x1::option::some<u64>(arg4), 0x1::option::none<u32>(), arg8, arg9);
        finish_swap<T0, 0x2::sui::SUI>(arg2, v3, v2, arg9)
    }

    public fun swap_exact_y_for_x<T0, T1>(arg0: &mut 0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::pool::Pool<T0, T1>, arg1: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg2: &mut 0x2::coin::Coin<T1>, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let (v0, v1) = prepare_exact_in<T1>(arg2, arg3, arg5, arg6, arg7, arg8, arg9);
        let (v2, v3) = 0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::pool::swap<T0, T1>(arg0, arg1, 0x2::balance::zero<T0>(), v0, false, true, arg3, v1, 0x1::option::some<u64>(arg4), 0x1::option::none<u32>(), arg8, arg9);
        finish_swap<T1, T0>(arg2, v3, v2, arg9)
    }

    public fun swap_exact_y_for_x_no_lending<T0, T1>(arg0: &mut 0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::pool::Pool<T0, T1>, arg1: &mut 0x2::coin::Coin<T1>, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let (v0, v1) = prepare_exact_in<T1>(arg1, arg2, arg4, arg5, arg6, arg7, arg8);
        let (v2, v3) = 0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::pool::swap_no_lending<T0, T1>(arg0, 0x2::balance::zero<T0>(), v0, false, true, arg2, v1, 0x1::option::some<u64>(arg3), 0x1::option::none<u32>(), arg7, arg8);
        finish_swap<T1, T0>(arg1, v3, v2, arg8)
    }

    public fun swap_exact_y_for_x_with_partner<T0, T1>(arg0: &mut 0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::pool::Pool<T0, T1>, arg1: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg2: &mut 0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::partner::Partner, arg3: &mut 0x2::coin::Coin<T1>, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(0x2::coin::value<T1>(arg3) >= arg4, 910);
        let (v0, v1) = prepare_exact_in<T1>(arg3, arg4, arg6, arg7, arg8, arg9, arg10);
        let (v2, v3) = 0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::pool::swap_with_partner<T0, T1>(arg0, arg1, arg2, 0x2::balance::zero<T0>(), v0, false, true, arg4, v1, 0x1::option::some<u64>(arg5), 0x1::option::none<u32>(), arg9, arg10);
        finish_swap<T1, T0>(arg3, v3, v2, arg10)
    }

    public fun swap_exact_y_for_x_with_partner_no_lending<T0, T1>(arg0: &mut 0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::pool::Pool<T0, T1>, arg1: &mut 0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::partner::Partner, arg2: &mut 0x2::coin::Coin<T1>, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(0x2::coin::value<T1>(arg2) >= arg3, 910);
        let (v0, v1) = prepare_exact_in<T1>(arg2, arg3, arg5, arg6, arg7, arg8, arg9);
        let (v2, v3) = 0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::pool::swap_with_partner_no_lending<T0, T1>(arg0, arg1, 0x2::balance::zero<T0>(), v0, false, true, arg3, v1, 0x1::option::some<u64>(arg4), 0x1::option::none<u32>(), arg8, arg9);
        finish_swap<T1, T0>(arg2, v3, v2, arg9)
    }

    public fun swap_sui_for_exact_y<T0>(arg0: &mut 0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::pool::Pool<0x2::sui::SUI, T0>, arg1: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg2: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg3: u64, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = prepare_exact_out<0x2::sui::SUI>(arg2, arg3, arg4, arg5, arg6, arg7);
        let (v1, v2) = 0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::pool::swap<0x2::sui::SUI, T0>(arg0, arg1, v0, 0x2::balance::zero<T0>(), true, false, arg3, arg4, 0x1::option::none<u64>(), 0x1::option::none<u32>(), arg6, arg7);
        finish_swap<0x2::sui::SUI, T0>(arg2, v1, v2, arg7)
    }

    public fun swap_sui_for_exact_y_with_partner<T0>(arg0: &mut 0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::pool::Pool<0x2::sui::SUI, T0>, arg1: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg2: &mut 0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::partner::Partner, arg3: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg4: u64, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = prepare_exact_out<0x2::sui::SUI>(arg3, arg4, arg5, arg6, arg7, arg8);
        let (v1, v2) = 0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::pool::swap_with_partner<0x2::sui::SUI, T0>(arg0, arg1, arg2, v0, 0x2::balance::zero<T0>(), true, false, arg4, arg5, 0x1::option::none<u64>(), 0x1::option::none<u32>(), arg7, arg8);
        finish_swap<0x2::sui::SUI, T0>(arg3, v1, v2, arg8)
    }

    public fun swap_x_for_exact_y<T0, T1>(arg0: &mut 0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::pool::Pool<T0, T1>, arg1: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg2: &mut 0x2::coin::Coin<T0>, arg3: u64, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = prepare_exact_out<T0>(arg2, arg3, arg4, arg5, arg6, arg7);
        let (v1, v2) = 0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::pool::swap<T0, T1>(arg0, arg1, v0, 0x2::balance::zero<T1>(), true, false, arg3, arg4, 0x1::option::none<u64>(), 0x1::option::none<u32>(), arg6, arg7);
        finish_swap<T0, T1>(arg2, v1, v2, arg7)
    }

    public fun swap_x_for_exact_y_no_lending<T0, T1>(arg0: &mut 0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::pool::Pool<T0, T1>, arg1: &mut 0x2::coin::Coin<T0>, arg2: u64, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = prepare_exact_out<T0>(arg1, arg2, arg3, arg4, arg5, arg6);
        let (v1, v2) = 0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::pool::swap_no_lending<T0, T1>(arg0, v0, 0x2::balance::zero<T1>(), true, false, arg2, arg3, 0x1::option::none<u64>(), 0x1::option::none<u32>(), arg5, arg6);
        finish_swap<T0, T1>(arg1, v1, v2, arg6)
    }

    public fun swap_x_for_exact_y_with_partner<T0, T1>(arg0: &mut 0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::pool::Pool<T0, T1>, arg1: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg2: &mut 0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::partner::Partner, arg3: &mut 0x2::coin::Coin<T0>, arg4: u64, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = prepare_exact_out<T0>(arg3, arg4, arg5, arg6, arg7, arg8);
        let (v1, v2) = 0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::pool::swap_with_partner<T0, T1>(arg0, arg1, arg2, v0, 0x2::balance::zero<T1>(), true, false, arg4, arg5, 0x1::option::none<u64>(), 0x1::option::none<u32>(), arg7, arg8);
        finish_swap<T0, T1>(arg3, v1, v2, arg8)
    }

    public fun swap_y_for_exact_sui<T0>(arg0: &mut 0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::pool::Pool<0x2::sui::SUI, T0>, arg1: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg2: &mut 0x2::coin::Coin<T0>, arg3: u64, arg4: u64, arg5: u64, arg6: &mut 0x3::sui_system::SuiSystemState, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        let v0 = prepare_exact_out<T0>(arg2, arg3, arg4, arg5, arg7, arg8);
        let (v1, v2) = 0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::pool::swap_sui_x<T0>(arg0, arg1, arg6, 0x2::balance::zero<0x2::sui::SUI>(), v0, false, false, arg3, arg4, 0x1::option::none<u64>(), 0x1::option::none<u32>(), arg7, arg8);
        finish_swap<T0, 0x2::sui::SUI>(arg2, v2, v1, arg8)
    }

    public fun swap_y_for_exact_sui_no_lending<T0>(arg0: &mut 0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::pool::Pool<0x2::sui::SUI, T0>, arg1: &mut 0x2::coin::Coin<T0>, arg2: u64, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        let v0 = prepare_exact_out<T0>(arg1, arg2, arg3, arg4, arg5, arg6);
        let (v1, v2) = 0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::pool::swap_no_lending<0x2::sui::SUI, T0>(arg0, 0x2::balance::zero<0x2::sui::SUI>(), v0, false, false, arg2, arg3, 0x1::option::none<u64>(), 0x1::option::none<u32>(), arg5, arg6);
        finish_swap<T0, 0x2::sui::SUI>(arg1, v2, v1, arg6)
    }

    public fun swap_y_for_exact_sui_with_partner<T0>(arg0: &mut 0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::pool::Pool<0x2::sui::SUI, T0>, arg1: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg2: &mut 0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::partner::Partner, arg3: &mut 0x2::coin::Coin<T0>, arg4: u64, arg5: u64, arg6: u64, arg7: &mut 0x3::sui_system::SuiSystemState, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        let v0 = prepare_exact_out<T0>(arg3, arg4, arg5, arg6, arg8, arg9);
        let (v1, v2) = 0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::pool::swap_sui_x_with_partner<T0>(arg0, arg1, arg2, arg7, 0x2::balance::zero<0x2::sui::SUI>(), v0, false, false, arg4, arg5, 0x1::option::none<u64>(), 0x1::option::none<u32>(), arg8, arg9);
        finish_swap<T0, 0x2::sui::SUI>(arg3, v2, v1, arg9)
    }

    public fun swap_y_for_exact_x<T0, T1>(arg0: &mut 0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::pool::Pool<T0, T1>, arg1: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg2: &mut 0x2::coin::Coin<T1>, arg3: u64, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = prepare_exact_out<T1>(arg2, arg3, arg4, arg5, arg6, arg7);
        let (v1, v2) = 0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::pool::swap<T0, T1>(arg0, arg1, 0x2::balance::zero<T0>(), v0, false, false, arg3, arg4, 0x1::option::none<u64>(), 0x1::option::none<u32>(), arg6, arg7);
        finish_swap<T1, T0>(arg2, v2, v1, arg7)
    }

    public fun swap_y_for_exact_x_no_lending<T0, T1>(arg0: &mut 0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::pool::Pool<T0, T1>, arg1: &mut 0x2::coin::Coin<T1>, arg2: u64, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = prepare_exact_out<T1>(arg1, arg2, arg3, arg4, arg5, arg6);
        let (v1, v2) = 0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::pool::swap_no_lending<T0, T1>(arg0, 0x2::balance::zero<T0>(), v0, false, false, arg2, arg3, 0x1::option::none<u64>(), 0x1::option::none<u32>(), arg5, arg6);
        finish_swap<T1, T0>(arg1, v2, v1, arg6)
    }

    public fun swap_y_for_exact_x_with_partner<T0, T1>(arg0: &mut 0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::pool::Pool<T0, T1>, arg1: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg2: &mut 0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::partner::Partner, arg3: &mut 0x2::coin::Coin<T1>, arg4: u64, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = prepare_exact_out<T1>(arg3, arg4, arg5, arg6, arg7, arg8);
        let (v1, v2) = 0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::pool::swap_with_partner<T0, T1>(arg0, arg1, arg2, 0x2::balance::zero<T0>(), v0, false, false, arg4, arg5, 0x1::option::none<u64>(), 0x1::option::none<u32>(), arg7, arg8);
        finish_swap<T1, T0>(arg3, v2, v1, arg8)
    }

    // decompiled from Move bytecode v7
}

