module 0xce31b131cc78d5e251b0e704070d7d66436915f21a0dfc907c80501595390d63::sob {
    struct SOB has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SOB>(arg0, 6, b"SOB", b"SUI ON BRETT", x"54686520636f6d6d756e6974792064726976656e206d6173636f7420244252455454206f6e200a405375694e6574776f726b0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/BRET_f1285d71e9.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SOB>>(v1);
    }

    // decompiled from Move bytecode v6
}

