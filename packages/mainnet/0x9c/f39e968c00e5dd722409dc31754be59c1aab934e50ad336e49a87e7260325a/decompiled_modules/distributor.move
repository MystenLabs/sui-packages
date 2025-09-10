module 0x9cf39e968c00e5dd722409dc31754be59c1aab934e50ad336e49a87e7260325a::distributor {
    struct RecipientDistributedEvent has copy, drop {
        distribute_id: 0x1::ascii::String,
        receiver: address,
        tokens: vector<0x1::ascii::String>,
        amounts: vector<u64>,
        time_ms: u64,
    }

    fun assert_all(arg0: &0x9cf39e968c00e5dd722409dc31754be59c1aab934e50ad336e49a87e7260325a::config::DistributeConfig, arg1: &0x2::tx_context::TxContext) {
        0x9cf39e968c00e5dd722409dc31754be59c1aab934e50ad336e49a87e7260325a::config::assert_operator(arg0, 0x2::tx_context::sender(arg1));
        0x9cf39e968c00e5dd722409dc31754be59c1aab934e50ad336e49a87e7260325a::config::assert_version(arg0);
        0x9cf39e968c00e5dd722409dc31754be59c1aab934e50ad336e49a87e7260325a::config::assert_paused(arg0);
    }

    public fun check_distributed_id(arg0: &mut 0x9cf39e968c00e5dd722409dc31754be59c1aab934e50ad336e49a87e7260325a::config::DistributeConfig, arg1: 0x1::ascii::String) : bool {
        0x9cf39e968c00e5dd722409dc31754be59c1aab934e50ad336e49a87e7260325a::config::check_distributed_id_existed(arg0, arg1)
    }

    entry fun distribute<T0, T1, T2>(arg0: &mut 0x9cf39e968c00e5dd722409dc31754be59c1aab934e50ad336e49a87e7260325a::config::DistributeConfig, arg1: 0x2::coin::Coin<T0>, arg2: 0x2::coin::Coin<T1>, arg3: 0x2::coin::Coin<T2>, arg4: vector<0x1::ascii::String>, arg5: vector<address>, arg6: vector<u64>, arg7: vector<u64>, arg8: vector<u64>, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        assert_all(arg0, arg10);
        let v0 = 0x1::vector::length<address>(&arg5);
        let v1 = if (v0 > 0) {
            if (v0 == 0x1::vector::length<0x1::ascii::String>(&arg4)) {
                if (v0 == 0x1::vector::length<u64>(&arg6)) {
                    if (v0 == 0x1::vector::length<u64>(&arg7)) {
                        v0 == 0x1::vector::length<u64>(&arg8)
                    } else {
                        false
                    }
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v1, 200);
        let v2 = 0x2::tx_context::sender(arg10);
        let v3 = 0;
        let v4 = 0;
        let v5 = 0;
        let v6 = 0;
        let v7 = 0x1::vector::empty<0x1::ascii::String>();
        let v8 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        let v9 = 0x1::type_name::into_string(0x1::type_name::get<T1>());
        let v10 = 0x1::type_name::into_string(0x1::type_name::get<T2>());
        0x1::vector::push_back<0x1::ascii::String>(&mut v7, v8);
        0x1::vector::push_back<0x1::ascii::String>(&mut v7, v9);
        0x1::vector::push_back<0x1::ascii::String>(&mut v7, v10);
        while (v3 < v0) {
            let v11 = 0x1::vector::empty<u64>();
            let v12 = *0x1::vector::borrow<address>(&arg5, v3);
            let v13 = *0x1::vector::borrow<0x1::ascii::String>(&arg4, v3);
            let v14 = *0x1::vector::borrow<u64>(&arg6, v3);
            assert!(!0x9cf39e968c00e5dd722409dc31754be59c1aab934e50ad336e49a87e7260325a::config::check_distributed_id_existed(arg0, v13), 201);
            if (v14 > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg1, v14, arg10), v12);
                v4 = v4 + v14;
            };
            let v15 = *0x1::vector::borrow<u64>(&arg7, v3);
            if (v15 > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::split<T1>(&mut arg2, v15, arg10), v12);
                v5 = v5 + v15;
            };
            let v16 = *0x1::vector::borrow<u64>(&arg8, v3);
            if (v16 > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x2::coin::split<T2>(&mut arg3, v16, arg10), v12);
                v6 = v6 + v16;
            };
            0x9cf39e968c00e5dd722409dc31754be59c1aab934e50ad336e49a87e7260325a::config::update_distributed_id(arg0, v13, arg10);
            0x1::vector::push_back<u64>(&mut v11, v14);
            0x1::vector::push_back<u64>(&mut v11, v15);
            0x1::vector::push_back<u64>(&mut v11, v16);
            let v17 = RecipientDistributedEvent{
                distribute_id : v13,
                receiver      : v12,
                tokens        : v7,
                amounts       : v11,
                time_ms       : 0x2::clock::timestamp_ms(arg9),
            };
            0x2::event::emit<RecipientDistributedEvent>(v17);
            v3 = v3 + 1;
        };
        0x9cf39e968c00e5dd722409dc31754be59c1aab934e50ad336e49a87e7260325a::config::update_total_distributed(arg0, v8, v4, arg10);
        0x9cf39e968c00e5dd722409dc31754be59c1aab934e50ad336e49a87e7260325a::config::update_total_distributed(arg0, v9, v5, arg10);
        0x9cf39e968c00e5dd722409dc31754be59c1aab934e50ad336e49a87e7260325a::config::update_total_distributed(arg0, v10, v6, arg10);
        if (0x2::coin::value<T0>(&arg1) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, v2);
        } else {
            0x2::coin::destroy_zero<T0>(arg1);
        };
        if (0x2::coin::value<T1>(&arg2) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(arg2, v2);
        } else {
            0x2::coin::destroy_zero<T1>(arg2);
        };
        if (0x2::coin::value<T2>(&arg3) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(arg3, v2);
        } else {
            0x2::coin::destroy_zero<T2>(arg3);
        };
    }

    // decompiled from Move bytecode v6
}

