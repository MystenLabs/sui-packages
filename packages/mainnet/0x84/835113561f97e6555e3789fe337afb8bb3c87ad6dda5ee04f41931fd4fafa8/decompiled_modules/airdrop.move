module 0x84835113561f97e6555e3789fe337afb8bb3c87ad6dda5ee04f41931fd4fafa8::airdrop {
    struct AdminCap has key {
        id: 0x2::object::UID,
        reward_cap: 0x2::coin::TreasuryCap<0xf4c8728e27863b2c5cca1bd2528a44a1f7c90f0e4e04d64ba356d7fc91ed0472::suip::SUIP>,
    }

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

    entry fun initialize_state<T0: store + key>(arg0: &0x84835113561f97e6555e3789fe337afb8bb3c87ad6dda5ee04f41931fd4fafa8::state::State, arg1: &mut AdminCap, arg2: T0, arg3: address, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        if (0x84835113561f97e6555e3789fe337afb8bb3c87ad6dda5ee04f41931fd4fafa8::state::get_state(arg0) < 4) {
            0x2::transfer::public_transfer<T0>(arg2, v0);
        } else {
            0x2::transfer::public_transfer<T0>(arg2, arg3);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0xf4c8728e27863b2c5cca1bd2528a44a1f7c90f0e4e04d64ba356d7fc91ed0472::suip::SUIP>>(0x2::coin::mint<0xf4c8728e27863b2c5cca1bd2528a44a1f7c90f0e4e04d64ba356d7fc91ed0472::suip::SUIP>(&mut arg1.reward_cap, arg4, arg5), v0);
    }

    fun is_correct_percent(arg0: u8) {
        assert!(arg0 >= 0 && arg0 <= 100, 2);
    }

    entry fun request_airdrop<T0>(arg0: &0x84835113561f97e6555e3789fe337afb8bb3c87ad6dda5ee04f41931fd4fafa8::state::State, arg1: &mut 0x84835113561f97e6555e3789fe337afb8bb3c87ad6dda5ee04f41931fd4fafa8::vault::Vault<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        if (0x84835113561f97e6555e3789fe337afb8bb3c87ad6dda5ee04f41931fd4fafa8::state::get_state(arg0) < 4) {
            0x84835113561f97e6555e3789fe337afb8bb3c87ad6dda5ee04f41931fd4fafa8::vault::request_airdrop<T0>(arg1, arg2, 0x2::tx_context::sender(arg3), arg3);
        };
    }

    public fun setup(arg0: 0x2::coin::TreasuryCap<0xf4c8728e27863b2c5cca1bd2528a44a1f7c90f0e4e04d64ba356d7fc91ed0472::suip::SUIP>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{
            id         : 0x2::object::new(arg1),
            reward_cap : arg0,
        };
        0x2::transfer::share_object<AdminCap>(v0);
    }

    // decompiled from Move bytecode v7
}

