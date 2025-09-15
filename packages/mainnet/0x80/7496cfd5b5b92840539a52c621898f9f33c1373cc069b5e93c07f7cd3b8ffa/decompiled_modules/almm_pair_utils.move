module 0x3e5412c072c805249ad38d62e5b773d4f77e85698eaff35952c988496b92481b::almm_pair_utils {
    public(friend) fun auto_fill_x_by_strategy(arg0: u32, arg1: u16, arg2: u64, arg3: u64, arg4: u64, arg5: u32, arg6: u32, arg7: u8) : u64 {
        let v0 = &arg7;
        let v1 = 1;
        if (v0 == &v1) {
            let (v3, v4) = to_weight_spot_balanced(arg5, arg6);
            auto_fill_x_by_weight(arg0, arg1, arg2, arg3, arg4, v3, v4)
        } else {
            let v5 = 2;
            if (v0 == &v5) {
                let (v6, v7) = to_weight_curve(arg5, arg6, arg0);
                auto_fill_x_by_weight(arg0, arg1, arg2, arg3, arg4, v6, v7)
            } else {
                let v8 = 3;
                assert!(v0 == &v8, 0);
                let (v9, v10) = to_weight_bid_ask(arg5, arg6, arg0);
                auto_fill_x_by_weight(arg0, arg1, arg2, arg3, arg4, v9, v10)
            }
        }
    }

    public(friend) fun auto_fill_x_by_weight(arg0: u32, arg1: u16, arg2: u64, arg3: u64, arg4: u64, arg5: vector<u32>, arg6: vector<u256>) : u64 {
        let v0 = 0;
        let v1 = 0x1::option::none<u256>();
        while (v0 < 0x1::vector::length<u32>(&arg5)) {
            if (*0x1::vector::borrow<u32>(&arg5, v0) == arg0) {
                0x1::option::fill<u256>(&mut v1, *0x1::vector::borrow<u256>(&arg6, v0));
            };
            v0 = v0 + 1;
        };
        if (0x1::option::is_some<u256>(&v1)) {
            let v3 = 0x1::option::extract<u256>(&mut v1);
            let v4 = 0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_price::get_price_from_storage_id(arg0, arg1);
            let v5 = 0;
            let v6 = 0;
            if (arg3 == 0 && arg4 == 0) {
                v5 = (v3 << 0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_constants::scale_offset()) / v4 * 2;
                v6 = v3 / 2;
            } else {
                if (arg3 > 0) {
                    v5 = (v3 << 0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_constants::scale_offset()) / (v4 + ((arg4 as u256) << 0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_constants::scale_offset()) / (arg3 as u256));
                };
                if (arg4 > 0) {
                    v6 = (v3 << 0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_constants::scale_offset()) / (0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_constants::scale() + v4 * (arg3 as u256) / (arg4 as u256));
                };
            };
            let v7 = v5;
            let v8 = v6;
            let v9 = 0;
            while (v9 < 0x1::vector::length<u32>(&arg5)) {
                if (*0x1::vector::borrow<u32>(&arg5, v9) < arg0) {
                    v8 = v8 + *0x1::vector::borrow<u256>(&arg6, v9);
                } else if (*0x1::vector::borrow<u32>(&arg5, v9) > arg0) {
                    v7 = v7 + (*0x1::vector::borrow<u256>(&arg6, v9) << 0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_constants::scale_offset()) / 0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_price::get_price_from_storage_id(*0x1::vector::borrow<u32>(&arg5, v9), arg1);
                };
                v9 = v9 + 1;
            };
            let v10 = if (v8 == 0) {
                0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_constants::scale() / 1000000000
            } else {
                ((arg2 as u256) << 0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_constants::scale_offset()) / v8
            };
            0xfd4fb46fa9cab466edbc46e95c9f647644018022780041b53c0f39602dfb8d8a::uint_safe::safe64(v10 * v7 >> 0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_constants::scale_offset())
        } else {
            let v11 = 0;
            let v12 = 0;
            let v13 = 0;
            while (v13 < 0x1::vector::length<u32>(&arg5)) {
                if (*0x1::vector::borrow<u32>(&arg5, v13) < arg0) {
                    v12 = v12 + *0x1::vector::borrow<u256>(&arg6, v13);
                } else {
                    v11 = v11 + (*0x1::vector::borrow<u256>(&arg6, v13) << 0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_constants::scale_offset()) / 0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_price::get_price_from_storage_id(*0x1::vector::borrow<u32>(&arg5, v13), arg1);
                };
                v13 = v13 + 1;
            };
            let v14 = if (v12 == 0) {
                0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_constants::scale() / 1000000000
            } else {
                ((arg2 as u256) << 0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_constants::scale_offset()) / v12
            };
            0xfd4fb46fa9cab466edbc46e95c9f647644018022780041b53c0f39602dfb8d8a::uint_safe::safe64(v14 * v11 >> 0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_constants::scale_offset())
        }
    }

    public(friend) fun auto_fill_y_by_strategy(arg0: u32, arg1: u16, arg2: u64, arg3: u64, arg4: u64, arg5: u32, arg6: u32, arg7: u8) : u64 {
        let v0 = &arg7;
        let v1 = 1;
        if (v0 == &v1) {
            let (v2, v3) = to_weight_spot_balanced(arg5, arg6);
            return auto_fill_y_by_weight(arg0, arg1, arg2, arg3, arg4, v2, v3)
        };
        let v4 = 2;
        if (v0 == &v4) {
            let (v5, v6) = to_weight_curve(arg5, arg6, arg0);
            return auto_fill_y_by_weight(arg0, arg1, arg2, arg3, arg4, v5, v6)
        };
        let v7 = 3;
        assert!(v0 == &v7, 0);
        let (v8, v9) = to_weight_bid_ask(arg5, arg6, arg0);
        auto_fill_y_by_weight(arg0, arg1, arg2, arg3, arg4, v8, v9)
    }

    public(friend) fun auto_fill_y_by_weight(arg0: u32, arg1: u16, arg2: u64, arg3: u64, arg4: u64, arg5: vector<u32>, arg6: vector<u256>) : u64 {
        let v0 = 0;
        let v1 = 0x1::option::none<u256>();
        while (v0 < 0x1::vector::length<u32>(&arg5)) {
            if (*0x1::vector::borrow<u32>(&arg5, v0) == arg0) {
                0x1::option::fill<u256>(&mut v1, *0x1::vector::borrow<u256>(&arg6, v0));
                break
            };
            v0 = v0 + 1;
        };
        if (0x1::option::is_some<u256>(&v1)) {
            let v3 = 0x1::option::extract<u256>(&mut v1);
            let v4 = 0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_price::get_price_from_storage_id(arg0, arg1);
            let v5 = 0;
            let v6 = 0;
            if (arg3 == 0 && arg4 == 0) {
                v5 = (v3 << 0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_constants::scale_offset()) / v4 * 2;
                v6 = v3 / 2;
            } else {
                if (arg3 > 0) {
                    v5 = (v3 << 0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_constants::scale_offset()) / (v4 + ((arg4 as u256) << 0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_constants::scale_offset()) / (arg3 as u256));
                };
                if (arg4 > 0) {
                    v6 = (v3 << 0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_constants::scale_offset()) / (0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_constants::scale() + v4 * (arg3 as u256) / (arg4 as u256));
                };
            };
            let v7 = v5;
            let v8 = v6;
            let v9 = 0;
            while (v9 < 0x1::vector::length<u32>(&arg5)) {
                if (*0x1::vector::borrow<u32>(&arg5, v9) < arg0) {
                    v8 = v8 + *0x1::vector::borrow<u256>(&arg6, v9);
                } else if (*0x1::vector::borrow<u32>(&arg5, v9) > arg0) {
                    v7 = v7 + (*0x1::vector::borrow<u256>(&arg6, v9) << 0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_constants::scale_offset()) / 0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_price::get_price_from_storage_id(*0x1::vector::borrow<u32>(&arg5, v9), arg1);
                };
                v9 = v9 + 1;
            };
            let v10 = if (v7 == 0) {
                0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_constants::scale() / 1000000000
            } else {
                ((arg2 as u256) << 0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_constants::scale_offset()) / v7
            };
            0xfd4fb46fa9cab466edbc46e95c9f647644018022780041b53c0f39602dfb8d8a::uint_safe::safe64(v10 * v8 >> 0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_constants::scale_offset())
        } else {
            let v11 = 0;
            let v12 = 0;
            let v13 = 0;
            while (v13 < 0x1::vector::length<u32>(&arg5)) {
                if (*0x1::vector::borrow<u32>(&arg5, v13) < arg0) {
                    v12 = v12 + *0x1::vector::borrow<u256>(&arg6, v13);
                } else {
                    v11 = v11 + (*0x1::vector::borrow<u256>(&arg6, v13) << 0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_constants::scale_offset()) / 0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_price::get_price_from_storage_id(*0x1::vector::borrow<u32>(&arg5, v13), arg1);
                };
                v13 = v13 + 1;
            };
            let v14 = if (v11 == 0) {
                0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_constants::scale()
            } else {
                ((arg2 as u256) << 0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_constants::scale_offset()) / v11
            };
            0xfd4fb46fa9cab466edbc46e95c9f647644018022780041b53c0f39602dfb8d8a::uint_safe::safe64(v14 * v12 >> 0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_constants::scale_offset())
        }
    }

    public fun strategy_bidask() : u8 {
        3
    }

    public fun strategy_curve() : u8 {
        2
    }

    public fun strategy_spot() : u8 {
        1
    }

    public(friend) fun to_amount_ask_side(arg0: u32, arg1: u16, arg2: u64, arg3: vector<u32>, arg4: vector<u256>) : vector<u64> {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<u32>(&arg3)) {
            let v2 = if (*0x1::vector::borrow<u32>(&arg3, v1) < arg0) {
                0
            } else {
                (*0x1::vector::borrow<u256>(&arg4, v1) << 0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_constants::scale_offset()) / 0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_price::get_price_from_storage_id(*0x1::vector::borrow<u32>(&arg3, v1), arg1)
            };
            v0 = v0 + v2;
            v1 = v1 + 1;
        };
        assert!(v0 > 0, 2);
        let v3 = 0x1::vector::empty<u64>();
        let v4 = 0;
        while (v4 < 0x1::vector::length<u32>(&arg3)) {
            if (*0x1::vector::borrow<u32>(&arg3, v4) < arg0) {
                0x1::vector::push_back<u64>(&mut v3, 0);
            } else {
                0x1::vector::push_back<u64>(&mut v3, 0xfd4fb46fa9cab466edbc46e95c9f647644018022780041b53c0f39602dfb8d8a::uint_safe::safe64((arg2 as u256) * (*0x1::vector::borrow<u256>(&arg4, v4) << 0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_constants::scale_offset()) / 0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_price::get_price_from_storage_id(*0x1::vector::borrow<u32>(&arg3, v4), arg1) / v0));
            };
            v4 = v4 + 1;
        };
        v3
    }

    public(friend) fun to_amount_bid_side(arg0: u32, arg1: u64, arg2: vector<u32>, arg3: vector<u256>) : vector<u64> {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<u32>(&arg2)) {
            let v2 = if (*0x1::vector::borrow<u32>(&arg2, v1) > arg0) {
                0
            } else {
                *0x1::vector::borrow<u256>(&arg3, v1)
            };
            v0 = v0 + v2;
            v1 = v1 + 1;
        };
        assert!(v0 > 0, 2);
        let v3 = 0x1::vector::empty<u64>();
        let v4 = 0;
        while (v4 < 0x1::vector::length<u32>(&arg2)) {
            if (*0x1::vector::borrow<u32>(&arg2, v4) > arg0) {
                0x1::vector::push_back<u64>(&mut v3, 0);
            } else {
                0x1::vector::push_back<u64>(&mut v3, 0xfd4fb46fa9cab466edbc46e95c9f647644018022780041b53c0f39602dfb8d8a::uint_safe::safe64((arg1 as u256) * *0x1::vector::borrow<u256>(&arg3, v4) / v0));
            };
            v4 = v4 + 1;
        };
        v3
    }

    public(friend) fun to_amount_both_side(arg0: u32, arg1: u16, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: vector<u32>, arg7: vector<u256>) : (vector<u64>, vector<u64>) {
        let v0 = 0x1::vector::empty<u64>();
        let v1 = 0x1::vector::empty<u64>();
        if (arg0 > *0x1::vector::borrow<u32>(&arg6, 0x1::vector::length<u32>(&arg6) - 1) || arg2 == 0) {
            let v2 = to_amount_bid_side(arg0, arg3, arg6, arg7);
            let v3 = 0;
            while (v3 < 0x1::vector::length<u32>(&arg6)) {
                0x1::vector::push_back<u64>(&mut v0, 0);
                0x1::vector::push_back<u64>(&mut v1, *0x1::vector::borrow<u64>(&v2, v3));
                v3 = v3 + 1;
            };
            return (v0, v1)
        };
        if (arg0 < *0x1::vector::borrow<u32>(&arg6, 0) || arg3 == 0) {
            let v4 = to_amount_ask_side(arg0, arg1, arg2, arg6, arg7);
            let v5 = 0;
            while (v5 < 0x1::vector::length<u32>(&arg6)) {
                0x1::vector::push_back<u64>(&mut v0, *0x1::vector::borrow<u64>(&v4, v5));
                0x1::vector::push_back<u64>(&mut v1, 0);
                v5 = v5 + 1;
            };
            return (v0, v1)
        };
        let v6 = 0x1::option::none<u256>();
        let v7 = 0;
        while (v7 < 0x1::vector::length<u32>(&arg6)) {
            if (*0x1::vector::borrow<u32>(&arg6, v7) == arg0) {
                0x1::option::fill<u256>(&mut v6, *0x1::vector::borrow<u256>(&arg7, v7));
                break
            };
            v7 = v7 + 1;
        };
        if (0x1::option::is_some<u256>(&v6)) {
            let v8 = 0x1::option::extract<u256>(&mut v6);
            let v9 = 0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_price::get_price_from_storage_id(arg0, arg1);
            let v10 = 0;
            let v11 = 0;
            if (arg4 == 0 && arg5 == 0) {
                v10 = (v8 << 0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_constants::scale_offset()) / v9 * 2;
                v11 = v8 / 2;
            } else {
                if (arg4 > 0) {
                    v10 = (v8 << 0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_constants::scale_offset()) / (v9 + ((arg5 as u256) << 0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_constants::scale_offset()) / (arg4 as u256));
                };
                if (arg5 > 0) {
                    v11 = (v8 << 0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_constants::scale_offset()) / (0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_constants::scale() + v9 * (arg4 as u256) / (arg5 as u256));
                };
            };
            let v12 = v10;
            let v13 = v11;
            let v14 = 0;
            while (v14 < 0x1::vector::length<u32>(&arg6)) {
                if (*0x1::vector::borrow<u32>(&arg6, v14) < arg0) {
                    v13 = v13 + *0x1::vector::borrow<u256>(&arg7, v14);
                };
                if (*0x1::vector::borrow<u32>(&arg6, v14) > arg0) {
                    v12 = v12 + (*0x1::vector::borrow<u256>(&arg7, v14) << 0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_constants::scale_offset()) / 0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_price::get_price_from_storage_id(*0x1::vector::borrow<u32>(&arg6, v14), arg1);
                };
                v14 = v14 + 1;
            };
            let v15 = (arg2 as u256) * 1000000000 / v12;
            let v16 = (arg3 as u256) * 1000000000 / v13;
            let v17 = if (v15 < v16) {
                v15
            } else {
                v16
            };
            let v18 = 0;
            while (v18 < 0x1::vector::length<u32>(&arg6)) {
                if (*0x1::vector::borrow<u32>(&arg6, v18) < arg0) {
                    0x1::vector::push_back<u64>(&mut v0, 0);
                    0x1::vector::push_back<u64>(&mut v1, 0xfd4fb46fa9cab466edbc46e95c9f647644018022780041b53c0f39602dfb8d8a::uint_safe::safe64(v17 * *0x1::vector::borrow<u256>(&arg7, v18) / 1000000000));
                } else if (*0x1::vector::borrow<u32>(&arg6, v18) > arg0) {
                    0x1::vector::push_back<u64>(&mut v0, 0xfd4fb46fa9cab466edbc46e95c9f647644018022780041b53c0f39602dfb8d8a::uint_safe::safe64(v17 * (*0x1::vector::borrow<u256>(&arg7, v18) << 0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_constants::scale_offset()) / 0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_price::get_price_from_storage_id(*0x1::vector::borrow<u32>(&arg6, v18), arg1) / 1000000000));
                    0x1::vector::push_back<u64>(&mut v1, 0);
                } else {
                    0x1::vector::push_back<u64>(&mut v0, 0xfd4fb46fa9cab466edbc46e95c9f647644018022780041b53c0f39602dfb8d8a::uint_safe::safe64(v17 * v10 / 1000000000));
                    0x1::vector::push_back<u64>(&mut v1, 0xfd4fb46fa9cab466edbc46e95c9f647644018022780041b53c0f39602dfb8d8a::uint_safe::safe64(v17 * v11 / 1000000000));
                };
                v18 = v18 + 1;
            };
            return (v0, v1)
        };
        let v19 = 0;
        let v20 = 0;
        let v21 = 0;
        while (v21 < 0x1::vector::length<u32>(&arg6)) {
            if (*0x1::vector::borrow<u32>(&arg6, v21) < arg0) {
                v20 = v20 + *0x1::vector::borrow<u256>(&arg7, v21);
            } else {
                v19 = v19 + (*0x1::vector::borrow<u256>(&arg7, v21) << 0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_constants::scale_offset()) / 0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_price::get_price_from_storage_id(*0x1::vector::borrow<u32>(&arg6, v21), arg1);
            };
            v21 = v21 + 1;
        };
        let v22 = (arg2 as u256) * 1000000000 / v19;
        let v23 = (arg3 as u256) * 1000000000 / v20;
        let v24 = if (v22 < v23) {
            v22
        } else {
            v23
        };
        let v25 = 0;
        while (v25 < 0x1::vector::length<u32>(&arg6)) {
            if (*0x1::vector::borrow<u32>(&arg6, v25) < arg0) {
                0x1::vector::push_back<u64>(&mut v0, 0);
                0x1::vector::push_back<u64>(&mut v1, 0xfd4fb46fa9cab466edbc46e95c9f647644018022780041b53c0f39602dfb8d8a::uint_safe::safe64(v24 * *0x1::vector::borrow<u256>(&arg7, v25) / 1000000000));
            } else {
                0x1::vector::push_back<u64>(&mut v0, 0xfd4fb46fa9cab466edbc46e95c9f647644018022780041b53c0f39602dfb8d8a::uint_safe::safe64(v24 * (*0x1::vector::borrow<u256>(&arg7, v25) << 0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_constants::scale_offset()) / 0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_price::get_price_from_storage_id(*0x1::vector::borrow<u32>(&arg6, v25), arg1) / 1000000000));
                0x1::vector::push_back<u64>(&mut v1, 0);
            };
            v25 = v25 + 1;
        };
        (v0, v1)
    }

    public(friend) fun to_weight_ascending_order(arg0: u32, arg1: u32) : (vector<u32>, vector<u256>) {
        let v0 = 0x1::vector::empty<u32>();
        let v1 = 0x1::vector::empty<u256>();
        while (arg0 <= arg1) {
            0x1::vector::push_back<u32>(&mut v0, arg0);
            0x1::vector::push_back<u256>(&mut v1, ((arg0 - arg0 + 1) as u256) * 1000000000);
            arg0 = arg0 + 1;
        };
        (v0, v1)
    }

    public(friend) fun to_weight_bid_ask(arg0: u32, arg1: u32, arg2: u32) : (vector<u32>, vector<u256>) {
        let v0 = 200 * 1000000000;
        let v1 = 2000 * 1000000000 - v0;
        let v2 = if (arg2 > arg0) {
            v1 / ((arg2 - arg0) as u256)
        } else {
            0
        };
        let v3 = if (arg1 > arg2) {
            v1 / ((arg1 - arg2) as u256)
        } else {
            0
        };
        let v4 = 0x1::vector::empty<u256>();
        let v5 = 0x1::vector::empty<u32>();
        while (arg0 <= arg1) {
            0x1::vector::push_back<u32>(&mut v5, arg0);
            if (arg0 < arg2) {
                0x1::vector::push_back<u256>(&mut v4, v0 + ((arg2 - arg0) as u256) * v2);
            } else if (arg0 > arg2) {
                0x1::vector::push_back<u256>(&mut v4, v0 + ((arg0 - arg2) as u256) * v3);
            } else {
                0x1::vector::push_back<u256>(&mut v4, v0);
            };
            arg0 = arg0 + 1;
        };
        (v5, v4)
    }

    public(friend) fun to_weight_curve(arg0: u32, arg1: u32, arg2: u32) : (vector<u32>, vector<u256>) {
        let v0 = 2000 * 1000000000;
        let v1 = v0 - 200 * 1000000000;
        let v2 = if (arg2 > arg0) {
            v1 / ((arg2 - arg0) as u256)
        } else {
            0
        };
        let v3 = if (arg1 > arg2) {
            v1 / ((arg1 - arg2) as u256)
        } else {
            0
        };
        let v4 = 0x1::vector::empty<u32>();
        let v5 = 0x1::vector::empty<u256>();
        while (arg0 <= arg1) {
            0x1::vector::push_back<u32>(&mut v4, arg0);
            if (arg0 < arg2) {
                0x1::vector::push_back<u256>(&mut v5, v0 - ((arg2 - arg0) as u256) * v2);
            } else if (arg0 > arg2) {
                0x1::vector::push_back<u256>(&mut v5, v0 - ((arg0 - arg2) as u256) * v3);
            } else {
                0x1::vector::push_back<u256>(&mut v5, v0);
            };
            arg0 = arg0 + 1;
        };
        (v4, v5)
    }

    public(friend) fun to_weight_descending_order(arg0: u32, arg1: u32) : (vector<u32>, vector<u256>) {
        let v0 = 0x1::vector::empty<u256>();
        let v1 = 0x1::vector::empty<u32>();
        while (arg0 <= arg1) {
            0x1::vector::push_back<u32>(&mut v1, arg0);
            0x1::vector::push_back<u256>(&mut v0, ((arg1 - arg0 + 1) as u256) * 1000000000);
            arg0 = arg0 + 1;
        };
        (v1, v0)
    }

    public(friend) fun to_weight_spot_balanced(arg0: u32, arg1: u32) : (vector<u32>, vector<u256>) {
        let v0 = 0x1::vector::empty<u256>();
        let v1 = 0x1::vector::empty<u32>();
        while (arg0 <= arg1) {
            0x1::vector::push_back<u32>(&mut v1, arg0);
            0x1::vector::push_back<u256>(&mut v0, 1000000000);
            arg0 = arg0 + 1;
        };
        (v1, v0)
    }

    // decompiled from Move bytecode v6
}

