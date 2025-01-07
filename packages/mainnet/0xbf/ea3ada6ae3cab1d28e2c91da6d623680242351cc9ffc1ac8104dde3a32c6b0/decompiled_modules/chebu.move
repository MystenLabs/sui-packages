module 0xbfea3ada6ae3cab1d28e2c91da6d623680242351cc9ffc1ac8104dde3a32c6b0::chebu {
    struct CHEBU has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHEBU, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v2::new<CHEBU>(arg0, 4722116258673425535, b"Cheburashka", b"Chebu", b"$Chebu launch on http://hop.fun", b"https://images.hop.ag/ipfs/Qmc4TXv7Xu5RQejUySSQThdEp2Nm8aX8sNbW4JacZDSudA", 0x1::string::utf8(b"https://x.com/cheburashkasui"), 0x1::string::utf8(b"https://www.cheburashkasui.com/"), 0x1::string::utf8(b"https://t.me/CheburashkaSui"), arg1);
    }

    // decompiled from Move bytecode v6
}

