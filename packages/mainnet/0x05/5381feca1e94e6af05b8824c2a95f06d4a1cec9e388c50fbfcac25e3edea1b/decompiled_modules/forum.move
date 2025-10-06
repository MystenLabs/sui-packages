module 0x55381feca1e94e6af05b8824c2a95f06d4a1cec9e388c50fbfcac25e3edea1b::forum {
    entry fun send(arg0: address, arg1: 0x1::string::String, arg2: &0x55381feca1e94e6af05b8824c2a95f06d4a1cec9e388c50fbfcac25e3edea1b::alpha::Alpha, arg3: &0x2::tx_context::TxContext) {
        assert!(arg0 == 0x2::tx_context::sender(arg3), 13906834217293053951);
        0x55381feca1e94e6af05b8824c2a95f06d4a1cec9e388c50fbfcac25e3edea1b::alpha::validate_version(arg2);
        assert!(0x1::string::length(&arg1) > 0, 13906834234472923135);
        0x55381feca1e94e6af05b8824c2a95f06d4a1cec9e388c50fbfcac25e3edea1b::event::forum_sent(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

