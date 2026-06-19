module 0xfd852d863902293629ca9c14567756a7f6fab77e5d261495f73c88e170cb1c16::airdrop {
    entry fun initialize<T0>(arg0: 0x2::coin::Coin<T0>, arg1: address, arg2: address, arg3: u8, arg4: &mut 0x2::tx_context::TxContext) {
        is_correct_percent(arg3);
        if (arg3 == 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, arg1);
        } else if (arg3 == 100) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, arg2);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg0, (((0x2::coin::value<T0>(&arg0) as u128) * (arg3 as u128) / 100) as u64), arg4), arg2);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, arg1);
        };
    }

    entry fun initialize_state<T0>(arg0: &0xfd852d863902293629ca9c14567756a7f6fab77e5d261495f73c88e170cb1c16::state::State, arg1: 0x2::coin::Coin<T0>, arg2: address, arg3: address, arg4: u8, arg5: &mut 0x2::tx_context::TxContext) {
        if (0xfd852d863902293629ca9c14567756a7f6fab77e5d261495f73c88e170cb1c16::state::get_state(arg0) < 4) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, 0x2::tx_context::sender(arg5));
        } else {
            is_correct_percent(arg4);
            if (arg4 == 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, arg2);
            } else if (arg4 == 100) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, arg3);
            } else {
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg1, (((0x2::coin::value<T0>(&arg1) as u128) * (arg4 as u128) / 100) as u64), arg5), arg3);
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, arg2);
            };
        };
    }

    fun is_correct_percent(arg0: u8) {
        assert!(arg0 >= 0 && arg0 <= 100, 2);
    }

    entry fun request_airdrop<T0>(arg0: &0xfd852d863902293629ca9c14567756a7f6fab77e5d261495f73c88e170cb1c16::state::State, arg1: &mut 0xfd852d863902293629ca9c14567756a7f6fab77e5d261495f73c88e170cb1c16::vault::Vault<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        if (0xfd852d863902293629ca9c14567756a7f6fab77e5d261495f73c88e170cb1c16::state::get_state(arg0) < 4) {
            0xfd852d863902293629ca9c14567756a7f6fab77e5d261495f73c88e170cb1c16::vault::request_airdrop<T0>(arg1, arg2, 0x2::tx_context::sender(arg3), arg3);
        };
    }

    // decompiled from Move bytecode v7
}

