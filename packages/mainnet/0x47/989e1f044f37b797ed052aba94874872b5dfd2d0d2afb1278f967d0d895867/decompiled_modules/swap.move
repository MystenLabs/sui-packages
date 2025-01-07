module 0x47989e1f044f37b797ed052aba94874872b5dfd2d0d2afb1278f967d0d895867::swap {
    public fun ascii_to_u64(arg0: vector<u8>) : u64 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<u8>(&arg0)) {
            let v2 = *0x1::vector::borrow<u8>(&arg0, v1);
            if (v2 < 48 || v2 > 57) {
                return 0
            };
            let v3 = v0 * 10;
            v0 = v3 + ((v2 - 48) as u64);
            v1 = v1 + 1;
        };
        v0
    }

    public fun get_cetus_amount_in<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: bool, arg2: u64) : u64 {
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculate_swap_result<T0, T1>(arg0, arg1, false, arg2);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_amount_in(&v0)
    }

    public fun get_cetus_amount_out<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: bool, arg2: u64) : u64 {
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculate_swap_result<T0, T1>(arg0, arg1, true, arg2);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_amount_out(&v0)
    }

    public fun right_type<T0>(arg0: vector<u8>) : bool {
        0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::get<T0>())) == arg0
    }

    public fun swap_for_base_asset_by_cetus<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: 0x2::coin::Coin<T1>, arg3: 0x47989e1f044f37b797ed052aba94874872b5dfd2d0d2afb1278f967d0d895867::cross::NormalizedSwapData, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>, u64) {
        assert!(right_type<T1>(0x47989e1f044f37b797ed052aba94874872b5dfd2d0d2afb1278f967d0d895867::cross::swap_sending_asset_id(arg3)), 2);
        assert!(right_type<T0>(0x47989e1f044f37b797ed052aba94874872b5dfd2d0d2afb1278f967d0d895867::cross::swap_receiving_asset_id(arg3)), 2);
        let v0 = 0x47989e1f044f37b797ed052aba94874872b5dfd2d0d2afb1278f967d0d895867::cross::swap_call_data(arg3);
        let v1 = 0;
        let v2 = 44;
        let (v3, v4) = 0x1::vector::index_of<u8>(&v0, &v2);
        let v5 = if (v3) {
            let v6 = 0x1::vector::length<u8>(&v0);
            if (v4 + 1 < v6) {
                v1 = ascii_to_u64(0x47989e1f044f37b797ed052aba94874872b5dfd2d0d2afb1278f967d0d895867::serde::vector_slice<u8>(&v0, v4 + 1, v6));
            };
            0x47989e1f044f37b797ed052aba94874872b5dfd2d0d2afb1278f967d0d895867::serde::vector_slice<u8>(&v0, 0, v4)
        } else {
            v0
        };
        assert!(v5 == b"Cetus", 1);
        let v7 = 0x2::coin::value<T1>(&arg2);
        let v8 = 0x2::coin::into_balance<T1>(arg2);
        let (v9, v10, v11) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, false, true, v7, 79226673515401279992447579055, arg4);
        let v12 = v11;
        let v13 = v10;
        let v14 = v9;
        let v15 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v12);
        assert!(v15 <= v7, 6);
        0x2::balance::join<T1>(&mut v13, v8);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::zero<T0>(), 0x2::balance::split<T1>(&mut v8, v15), v12);
        let v16 = 0x2::balance::value<T0>(&v14);
        assert!(v16 >= v15 * 100000000 / v7 * v1 / 100000000, 5);
        (0x2::coin::from_balance<T0>(v14, arg5), 0x2::coin::from_balance<T1>(v13, arg5), v16)
    }

    public fun swap_for_base_asset_by_deepbook<T0, T1>(arg0: &mut 0xdee9::clob::Pool<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: 0x47989e1f044f37b797ed052aba94874872b5dfd2d0d2afb1278f967d0d895867::cross::NormalizedSwapData, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>, u64) {
        assert!(right_type<T1>(0x47989e1f044f37b797ed052aba94874872b5dfd2d0d2afb1278f967d0d895867::cross::swap_sending_asset_id(arg2)), 2);
        assert!(right_type<T0>(0x47989e1f044f37b797ed052aba94874872b5dfd2d0d2afb1278f967d0d895867::cross::swap_receiving_asset_id(arg2)), 2);
        let v0 = 0x47989e1f044f37b797ed052aba94874872b5dfd2d0d2afb1278f967d0d895867::cross::swap_call_data(arg2);
        let v1 = 0;
        let v2 = 44;
        let (v3, v4) = 0x1::vector::index_of<u8>(&v0, &v2);
        let v5 = if (v3) {
            let v6 = 0x1::vector::length<u8>(&v0);
            if (v4 + 1 < v6) {
                v1 = ascii_to_u64(0x47989e1f044f37b797ed052aba94874872b5dfd2d0d2afb1278f967d0d895867::serde::vector_slice<u8>(&v0, v4 + 1, v6));
            };
            0x47989e1f044f37b797ed052aba94874872b5dfd2d0d2afb1278f967d0d895867::serde::vector_slice<u8>(&v0, 0, v4)
        } else {
            v0
        };
        assert!(v5 == b"DeepBook", 1);
        let v7 = 0x2::coin::value<T1>(&arg1);
        let (v8, v9, v10) = 0xdee9::clob::swap_exact_quote_for_base<T0, T1>(arg0, v7, arg3, arg1, arg4);
        let v11 = v9;
        assert!(v10 >= (v7 - 0x2::coin::value<T1>(&v11)) * 100000000 / v7 * v1 / 100000000, 5);
        (v8, v11, v10)
    }

    public fun swap_for_quote_asset_by_cetus<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: 0x2::coin::Coin<T0>, arg3: 0x47989e1f044f37b797ed052aba94874872b5dfd2d0d2afb1278f967d0d895867::cross::NormalizedSwapData, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>, u64) {
        assert!(right_type<T0>(0x47989e1f044f37b797ed052aba94874872b5dfd2d0d2afb1278f967d0d895867::cross::swap_sending_asset_id(arg3)), 2);
        assert!(right_type<T1>(0x47989e1f044f37b797ed052aba94874872b5dfd2d0d2afb1278f967d0d895867::cross::swap_receiving_asset_id(arg3)), 2);
        let v0 = 0x47989e1f044f37b797ed052aba94874872b5dfd2d0d2afb1278f967d0d895867::cross::swap_call_data(arg3);
        let v1 = 0;
        let v2 = 44;
        let (v3, v4) = 0x1::vector::index_of<u8>(&v0, &v2);
        let v5 = if (v3) {
            let v6 = 0x1::vector::length<u8>(&v0);
            if (v4 + 1 < v6) {
                v1 = ascii_to_u64(0x47989e1f044f37b797ed052aba94874872b5dfd2d0d2afb1278f967d0d895867::serde::vector_slice<u8>(&v0, v4 + 1, v6));
            };
            0x47989e1f044f37b797ed052aba94874872b5dfd2d0d2afb1278f967d0d895867::serde::vector_slice<u8>(&v0, 0, v4)
        } else {
            v0
        };
        assert!(v5 == b"Cetus", 1);
        let v7 = 0x2::coin::value<T0>(&arg2);
        let v8 = 0x2::coin::into_balance<T0>(arg2);
        let (v9, v10, v11) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, true, true, v7, 4295048016, arg4);
        let v12 = v11;
        let v13 = v10;
        let v14 = v9;
        let v15 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v12);
        assert!(v15 <= v7, 6);
        0x2::balance::join<T0>(&mut v14, v8);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::split<T0>(&mut v8, v15), 0x2::balance::zero<T1>(), v12);
        let v16 = 0x2::balance::value<T1>(&v13);
        assert!(v16 >= v15 * 100000000 / v7 * v1 / 100000000, 5);
        (0x2::coin::from_balance<T0>(v14, arg5), 0x2::coin::from_balance<T1>(v13, arg5), v16)
    }

    public fun swap_for_quote_asset_by_deepbook<T0, T1>(arg0: &mut 0xdee9::clob::Pool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: 0x47989e1f044f37b797ed052aba94874872b5dfd2d0d2afb1278f967d0d895867::cross::NormalizedSwapData, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>, u64) {
        assert!(right_type<T0>(0x47989e1f044f37b797ed052aba94874872b5dfd2d0d2afb1278f967d0d895867::cross::swap_sending_asset_id(arg2)), 2);
        assert!(right_type<T1>(0x47989e1f044f37b797ed052aba94874872b5dfd2d0d2afb1278f967d0d895867::cross::swap_receiving_asset_id(arg2)), 2);
        let v0 = 0x47989e1f044f37b797ed052aba94874872b5dfd2d0d2afb1278f967d0d895867::cross::swap_call_data(arg2);
        let v1 = 0;
        let v2 = 44;
        let (v3, v4) = 0x1::vector::index_of<u8>(&v0, &v2);
        let v5 = if (v3) {
            let v6 = 0x1::vector::length<u8>(&v0);
            if (v4 + 1 < v6) {
                v1 = ascii_to_u64(0x47989e1f044f37b797ed052aba94874872b5dfd2d0d2afb1278f967d0d895867::serde::vector_slice<u8>(&v0, v4 + 1, v6));
            };
            0x47989e1f044f37b797ed052aba94874872b5dfd2d0d2afb1278f967d0d895867::serde::vector_slice<u8>(&v0, 0, v4)
        } else {
            v0
        };
        assert!(v5 == b"DeepBook", 1);
        let v7 = 0x2::coin::value<T0>(&arg1);
        let (v8, v9, v10) = 0xdee9::clob::swap_exact_base_for_quote<T0, T1>(arg0, v7, arg1, 0x2::coin::zero<T1>(arg4), arg3, arg4);
        let v11 = v8;
        assert!(v10 >= (v7 - 0x2::coin::value<T0>(&v11)) * 100000000 / v7 * v1 / 100000000, 5);
        (v11, v9, v10)
    }

    // decompiled from Move bytecode v6
}

