module 0xfa455e6998a4b7b67f306fc9cf7b4ce9641e235dcc6b805b6135a491837ada13::airdrop {
    struct AdminCap has key {
        id: 0x2::object::UID,
        reward_cap: 0x2::coin::TreasuryCap<0xf4c8728e27863b2c5cca1bd2528a44a1f7c90f0e4e04d64ba356d7fc91ed0472::suip::SUIP>,
    }

    entry fun deposit_coin<T0>(arg0: &0xfa455e6998a4b7b67f306fc9cf7b4ce9641e235dcc6b805b6135a491837ada13::state::State, arg1: &0x2::clock::Clock, arg2: address, arg3: 0x2::coin::Coin<T0>, arg4: &mut 0x2::tx_context::TxContext) {
        if (0xfa455e6998a4b7b67f306fc9cf7b4ce9641e235dcc6b805b6135a491837ada13::state::live(arg0, arg1)) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg3, arg2);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg3, 0x2::tx_context::sender(arg4));
        };
    }

    entry fun deposit_object<T0: store + key>(arg0: &0xfa455e6998a4b7b67f306fc9cf7b4ce9641e235dcc6b805b6135a491837ada13::state::State, arg1: &0x2::clock::Clock, arg2: address, arg3: T0, arg4: &mut 0x2::tx_context::TxContext) {
        if (0xfa455e6998a4b7b67f306fc9cf7b4ce9641e235dcc6b805b6135a491837ada13::state::live(arg0, arg1)) {
            0x2::transfer::public_transfer<T0>(arg3, arg2);
        } else {
            0x2::transfer::public_transfer<T0>(arg3, 0x2::tx_context::sender(arg4));
        };
    }

    entry fun deposit_object_reward<T0: store + key>(arg0: &0xfa455e6998a4b7b67f306fc9cf7b4ce9641e235dcc6b805b6135a491837ada13::state::State, arg1: &0x2::clock::Clock, arg2: address, arg3: &mut AdminCap, arg4: T0, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg6);
        if (arg5 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0xf4c8728e27863b2c5cca1bd2528a44a1f7c90f0e4e04d64ba356d7fc91ed0472::suip::SUIP>>(0x2::coin::mint<0xf4c8728e27863b2c5cca1bd2528a44a1f7c90f0e4e04d64ba356d7fc91ed0472::suip::SUIP>(&mut arg3.reward_cap, arg5, arg6), v0);
        };
        if (0xfa455e6998a4b7b67f306fc9cf7b4ce9641e235dcc6b805b6135a491837ada13::state::live(arg0, arg1)) {
            0x2::transfer::public_transfer<T0>(arg4, arg2);
        } else {
            0x2::transfer::public_transfer<T0>(arg4, v0);
        };
    }

    entry fun setup(arg0: 0x2::coin::TreasuryCap<0xf4c8728e27863b2c5cca1bd2528a44a1f7c90f0e4e04d64ba356d7fc91ed0472::suip::SUIP>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{
            id         : 0x2::object::new(arg1),
            reward_cap : arg0,
        };
        0x2::transfer::share_object<AdminCap>(v0);
    }

    // decompiled from Move bytecode v7
}

