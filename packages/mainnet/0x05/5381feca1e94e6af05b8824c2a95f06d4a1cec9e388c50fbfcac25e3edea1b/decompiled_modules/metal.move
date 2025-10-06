module 0x55381feca1e94e6af05b8824c2a95f06d4a1cec9e388c50fbfcac25e3edea1b::metal {
    fun calculate_challenge_amount(arg0: u256) : u256 {
        let v0 = 0x1::vector::empty<u256>();
        let v1 = &mut v0;
        0x1::vector::push_back<u256>(v1, 1000000000);
        0x1::vector::push_back<u256>(v1, 3000000000);
        0x1::vector::push_back<u256>(v1, 6000000000);
        0x1::vector::push_back<u256>(v1, 10000000000);
        *0x1::vector::borrow<u256>(&v0, 0x55381feca1e94e6af05b8824c2a95f06d4a1cec9e388c50fbfcac25e3edea1b::alpha::to_u64(arg0 - 1))
    }

    entry fun challenge(arg0: address, arg1: u256, arg2: u256, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &mut 0x55381feca1e94e6af05b8824c2a95f06d4a1cec9e388c50fbfcac25e3edea1b::alpha::Alpha, arg5: &0x2::random::Random, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg0 == 0x2::tx_context::sender(arg6), 13906834337552138239);
        0x55381feca1e94e6af05b8824c2a95f06d4a1cec9e388c50fbfcac25e3edea1b::alpha::validate_version(arg4);
        let v0 = 0x55381feca1e94e6af05b8824c2a95f06d4a1cec9e388c50fbfcac25e3edea1b::alpha::to_u256(0x2::balance::value<0x2::sui::SUI>(0x2::coin::balance<0x2::sui::SUI>(&arg3)));
        0x55381feca1e94e6af05b8824c2a95f06d4a1cec9e388c50fbfcac25e3edea1b::vault::add_coins_to_balance(arg4, arg3);
        assert!(arg1 > 0, 13906834371911876607);
        assert!(arg1 <= 4, 13906834376206843903);
        assert!(arg2 <= 1, 13906834389091745791);
        assert!(v0 == calculate_challenge_amount(arg1), 13906834401976647679);
        let v1 = 0x2::address::from_u256(0x55381feca1e94e6af05b8824c2a95f06d4a1cec9e388c50fbfcac25e3edea1b::state::get_global_value(arg4, global_defender(arg1)));
        assert!(arg0 != v1, 13906834432041418751);
        let v2 = 0x55381feca1e94e6af05b8824c2a95f06d4a1cec9e388c50fbfcac25e3edea1b::wheel::get_random(arg4, arg5, arg6);
        let v3 = if (v2 % 2 == arg2) {
            arg0
        } else {
            v1
        };
        if (v3 == arg0) {
            0x55381feca1e94e6af05b8824c2a95f06d4a1cec9e388c50fbfcac25e3edea1b::state::set_global_value(arg4, global_defender(arg1), 0x2::address::to_u256(v3));
        };
        0x55381feca1e94e6af05b8824c2a95f06d4a1cec9e388c50fbfcac25e3edea1b::kyovy::mint_tokens(arg0, v0, arg4, arg6);
        0x55381feca1e94e6af05b8824c2a95f06d4a1cec9e388c50fbfcac25e3edea1b::vault::send_coins_to_admin(arg4, v0 * 20 / 1000, arg6);
        0x55381feca1e94e6af05b8824c2a95f06d4a1cec9e388c50fbfcac25e3edea1b::cycle::add_coins_to_next(v0 * 30 / 1000, arg4);
        0x55381feca1e94e6af05b8824c2a95f06d4a1cec9e388c50fbfcac25e3edea1b::cycle::add_tokens_to_next(v0, arg4);
        let v4 = v0 * 950 / 1000;
        0x55381feca1e94e6af05b8824c2a95f06d4a1cec9e388c50fbfcac25e3edea1b::vault::send_coins_to_account(arg4, v3, v4, arg6);
        0x55381feca1e94e6af05b8824c2a95f06d4a1cec9e388c50fbfcac25e3edea1b::event::metal_challenged(arg0, arg1, arg2, v2, arg0, v1, v3, v0, v0, v4);
    }

    fun global_defender(arg0: u256) : 0x1::string::String {
        let v0 = 0x1::string::utf8(b"metal_defender_");
        0x1::string::append(&mut v0, 0x1::u256::to_string(arg0));
        v0
    }

    entry fun setup(arg0: address, arg1: &mut 0x55381feca1e94e6af05b8824c2a95f06d4a1cec9e388c50fbfcac25e3edea1b::alpha::Alpha, arg2: &0x2::tx_context::TxContext) {
        assert!(arg0 == 0x2::tx_context::sender(arg2), 13906834303192399871);
        0x55381feca1e94e6af05b8824c2a95f06d4a1cec9e388c50fbfcac25e3edea1b::alpha::validate_admin(arg1, arg0);
        0x55381feca1e94e6af05b8824c2a95f06d4a1cec9e388c50fbfcac25e3edea1b::alpha::validate_version(arg1);
        update_defenders(arg0, arg1);
    }

    fun update_defenders(arg0: address, arg1: &mut 0x55381feca1e94e6af05b8824c2a95f06d4a1cec9e388c50fbfcac25e3edea1b::alpha::Alpha) {
        let v0 = 1;
        while (v0 <= 4) {
            if (0x55381feca1e94e6af05b8824c2a95f06d4a1cec9e388c50fbfcac25e3edea1b::state::get_global_value(arg1, global_defender(v0)) == 0) {
                0x55381feca1e94e6af05b8824c2a95f06d4a1cec9e388c50fbfcac25e3edea1b::state::set_global_value(arg1, global_defender(v0), 0x2::address::to_u256(arg0));
            };
            v0 = v0 + 1;
        };
    }

    // decompiled from Move bytecode v6
}

