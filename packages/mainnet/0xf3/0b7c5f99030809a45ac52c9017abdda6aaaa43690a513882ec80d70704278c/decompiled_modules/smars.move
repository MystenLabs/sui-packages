module 0xf30b7c5f99030809a45ac52c9017abdda6aaaa43690a513882ec80d70704278c::smars {
    struct SMARS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMARS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMARS>(arg0, 6, b"SMARS", b"MARS Coin", x"41206d656d6520636f696e2066726f6d20706c616e6574204d6172732e0a4e4f20546f6b656e6f6d6963732e0a4e4f204472616d612e0a4a7573742061206d656d6520636f696e2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/al4p9_QT_3_400x400_215989a765.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMARS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SMARS>>(v1);
    }

    // decompiled from Move bytecode v6
}

