module 0x79cea755890faf31635d4624d8ba7b910950a613239a8cef5931e82ee2224487::bluefin {
    public fun confirm_swap<T0, T1>(arg0: &mut 0x79cea755890faf31635d4624d8ba7b910950a613239a8cef5931e82ee2224487::config::Config, arg1: 0x79cea755890faf31635d4624d8ba7b910950a613239a8cef5931e82ee2224487::config::SwapRequest, arg2: &0xe8f996ea6ff38c557c253d3b93cfe2ebf393816487266786371aa4532a9229f2::config::Config, arg3: &mut 0xe8f996ea6ff38c557c253d3b93cfe2ebf393816487266786371aa4532a9229f2::vault::Vault, arg4: 0x2::coin::Coin<T1>, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x79cea755890faf31635d4624d8ba7b910950a613239a8cef5931e82ee2224487::config::checked_package_version(arg0);
        0x79cea755890faf31635d4624d8ba7b910950a613239a8cef5931e82ee2224487::config::checked_pause(arg0);
        let (v0, v1, v2, v3, v4, v5) = 0x79cea755890faf31635d4624d8ba7b910950a613239a8cef5931e82ee2224487::config::destroy_swap_request(arg1);
        assert!(v2 == 0x1::type_name::get<T1>(), 3);
        let v6 = 0x2::coin::zero<T1>(arg5);
        0x2::coin::join<T1>(&mut v6, arg4);
        0xe8f996ea6ff38c557c253d3b93cfe2ebf393816487266786371aa4532a9229f2::settle::settle<T0, T1>(arg2, arg3, v3, &mut v6, v4, 0x2::coin::value<T1>(&v6), 0x1::option::none<address>(), 0, 0, arg5);
        let (v7, v8) = 0x79cea755890faf31635d4624d8ba7b910950a613239a8cef5931e82ee2224487::config::deduct_fee<T1>(arg0, v6, arg5);
        let v9 = v7;
        assert!(0x2::coin::value<T1>(&v9) >= v4, 2);
        0x79cea755890faf31635d4624d8ba7b910950a613239a8cef5931e82ee2224487::config::emit_confirm_swap_event(v0, v1, v2, v3, 0x2::coin::value<T1>(&v9), v4, v8, v5);
        v9
    }

    public fun start_swap<T0, T1>(arg0: &0x79cea755890faf31635d4624d8ba7b910950a613239a8cef5931e82ee2224487::config::Config, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : (0x79cea755890faf31635d4624d8ba7b910950a613239a8cef5931e82ee2224487::config::SwapRequest, 0x2::coin::Coin<T0>) {
        0x79cea755890faf31635d4624d8ba7b910950a613239a8cef5931e82ee2224487::config::checked_package_version(arg0);
        0x79cea755890faf31635d4624d8ba7b910950a613239a8cef5931e82ee2224487::config::checked_pause(arg0);
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 > 0, 1);
        let v1 = 0x79cea755890faf31635d4624d8ba7b910950a613239a8cef5931e82ee2224487::config::new_swap_request(0x1::type_name::get<T0>(), 0x1::type_name::get<T1>(), v0, arg2, b"BLUEFIN", arg3);
        0x79cea755890faf31635d4624d8ba7b910950a613239a8cef5931e82ee2224487::config::emit_start_swap_event(&v1);
        (v1, arg1)
    }

    // decompiled from Move bytecode v6
}

