module 0xd51017251e888ac64f26250bf0fbf968a90d661ee01b81c7873a99d0e87a4c6f::airdrop {
    struct AdminCap has key {
        id: 0x2::object::UID,
        reward_cap: 0x2::coin::TreasuryCap<0x8041ab4eafa03bc7cf8348ab841d416475d703a0c66d34104a8bcea95a4de67b::suip::SUIP>,
    }

    entry fun deposit_coin<T0>(arg0: &0xd51017251e888ac64f26250bf0fbf968a90d661ee01b81c7873a99d0e87a4c6f::state::State, arg1: &0x2::clock::Clock, arg2: address, arg3: 0x2::coin::Coin<T0>, arg4: &mut 0x2::tx_context::TxContext) {
        if (0xd51017251e888ac64f26250bf0fbf968a90d661ee01b81c7873a99d0e87a4c6f::state::live(arg0, arg1)) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg3, arg2);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg3, 0x2::tx_context::sender(arg4));
        };
    }

    entry fun deposit_coin_mut<T0>(arg0: &0xd51017251e888ac64f26250bf0fbf968a90d661ee01b81c7873a99d0e87a4c6f::state::State, arg1: &0x2::clock::Clock, arg2: address, arg3: &mut 0x2::coin::Coin<T0>, arg4: &mut 0x2::tx_context::TxContext) {
        if (0xd51017251e888ac64f26250bf0fbf968a90d661ee01b81c7873a99d0e87a4c6f::state::live(arg0, arg1)) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(arg3, 0x2::coin::value<T0>(arg3), arg4), arg2);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(arg3, 0x2::coin::value<T0>(arg3), arg4), 0x2::tx_context::sender(arg4));
        };
    }

    entry fun deposit_object<T0: store + key>(arg0: &0xd51017251e888ac64f26250bf0fbf968a90d661ee01b81c7873a99d0e87a4c6f::state::State, arg1: &0x2::clock::Clock, arg2: address, arg3: T0, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0xd51017251e888ac64f26250bf0fbf968a90d661ee01b81c7873a99d0e87a4c6f::state::live(arg0, arg1), 7);
        0x2::transfer::public_transfer<T0>(arg3, arg2);
    }

    entry fun deposit_object_reward<T0: store + key>(arg0: &0xd51017251e888ac64f26250bf0fbf968a90d661ee01b81c7873a99d0e87a4c6f::state::State, arg1: &0x2::clock::Clock, arg2: address, arg3: &mut AdminCap, arg4: T0, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0xd51017251e888ac64f26250bf0fbf968a90d661ee01b81c7873a99d0e87a4c6f::state::live(arg0, arg1), 7);
        if (arg5 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x8041ab4eafa03bc7cf8348ab841d416475d703a0c66d34104a8bcea95a4de67b::suip::SUIP>>(0x2::coin::mint<0x8041ab4eafa03bc7cf8348ab841d416475d703a0c66d34104a8bcea95a4de67b::suip::SUIP>(&mut arg3.reward_cap, arg5, arg6), 0x2::tx_context::sender(arg6));
        };
        0x2::transfer::public_transfer<T0>(arg4, arg2);
    }

    entry fun setup(arg0: 0x2::coin::TreasuryCap<0x8041ab4eafa03bc7cf8348ab841d416475d703a0c66d34104a8bcea95a4de67b::suip::SUIP>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{
            id         : 0x2::object::new(arg1),
            reward_cap : arg0,
        };
        0x2::transfer::share_object<AdminCap>(v0);
    }

    // decompiled from Move bytecode v7
}

