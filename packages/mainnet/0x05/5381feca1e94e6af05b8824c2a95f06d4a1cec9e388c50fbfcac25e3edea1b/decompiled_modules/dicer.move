module 0x55381feca1e94e6af05b8824c2a95f06d4a1cec9e388c50fbfcac25e3edea1b::dicer {
    entry fun roll(arg0: address, arg1: u256, arg2: u256, arg3: 0x2::coin::Coin<0x55381feca1e94e6af05b8824c2a95f06d4a1cec9e388c50fbfcac25e3edea1b::kyovy::KYOVY>, arg4: &mut 0x55381feca1e94e6af05b8824c2a95f06d4a1cec9e388c50fbfcac25e3edea1b::alpha::Alpha, arg5: &0x2::random::Random, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg0 == 0x2::tx_context::sender(arg6), 13906834255947759615);
        0x55381feca1e94e6af05b8824c2a95f06d4a1cec9e388c50fbfcac25e3edea1b::alpha::validate_version(arg4);
        let v0 = 0x55381feca1e94e6af05b8824c2a95f06d4a1cec9e388c50fbfcac25e3edea1b::alpha::to_u256(0x2::balance::value<0x55381feca1e94e6af05b8824c2a95f06d4a1cec9e388c50fbfcac25e3edea1b::kyovy::KYOVY>(0x2::coin::balance<0x55381feca1e94e6af05b8824c2a95f06d4a1cec9e388c50fbfcac25e3edea1b::kyovy::KYOVY>(&arg3)));
        0x55381feca1e94e6af05b8824c2a95f06d4a1cec9e388c50fbfcac25e3edea1b::kyovy::burn_tokens(arg3, arg4);
        assert!(v0 >= 1000000000, 13906834290307497983);
        assert!(v0 <= 1000000000000, 13906834294602465279);
        assert!(arg1 <= arg2, 13906834307487367167);
        assert!(arg1 >= 0x55381feca1e94e6af05b8824c2a95f06d4a1cec9e388c50fbfcac25e3edea1b::wheel::random_min(), 13906834311782334463);
        assert!(arg1 <= 0x55381feca1e94e6af05b8824c2a95f06d4a1cec9e388c50fbfcac25e3edea1b::wheel::random_max(), 13906834316077301759);
        assert!(arg2 >= 0x55381feca1e94e6af05b8824c2a95f06d4a1cec9e388c50fbfcac25e3edea1b::wheel::random_min(), 13906834320372269055);
        assert!(arg2 <= 0x55381feca1e94e6af05b8824c2a95f06d4a1cec9e388c50fbfcac25e3edea1b::wheel::random_max(), 13906834324667236351);
        let v1 = 0x55381feca1e94e6af05b8824c2a95f06d4a1cec9e388c50fbfcac25e3edea1b::wheel::get_random(arg4, arg5, arg6);
        let v2 = arg2 - arg1 + 1;
        let v3 = 0;
        if (v1 >= arg1 && v1 <= arg2) {
            v3 = v0 * (0x55381feca1e94e6af05b8824c2a95f06d4a1cec9e388c50fbfcac25e3edea1b::wheel::random_max() - 0x55381feca1e94e6af05b8824c2a95f06d4a1cec9e388c50fbfcac25e3edea1b::wheel::random_min() + 1) * 970 / v2 * 1000;
        };
        if (v3 > 0) {
            0x55381feca1e94e6af05b8824c2a95f06d4a1cec9e388c50fbfcac25e3edea1b::kyovy::mint_tokens(arg0, v3, arg4, arg6);
        };
        0x55381feca1e94e6af05b8824c2a95f06d4a1cec9e388c50fbfcac25e3edea1b::event::dicer_rolled(arg0, v0, arg1, arg2, v1, v2, v3);
    }

    // decompiled from Move bytecode v6
}

