module 0xe9d3888db8500e7f31ed5280130a935122df849ef35a94f280edd6f9a3ffcc22::smc {
    struct SMC has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMC>(arg0, 6, b"SMC", b"Suimon Cow", b"Once upon a blockchain, a curious cow named SUIMON wandered a bit too far and splash! found himself stranded in the middle of the vast, digital ocean. With only waves around and nowhere to graze, He is now moo-ing for rescue. And who can save him? You can! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/a_Q_Mfa_SR_400x400_06c1ca0365.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SMC>>(v1);
    }

    // decompiled from Move bytecode v6
}

