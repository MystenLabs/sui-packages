module 0xd97244a18bade443310cb752ea934a5ff9c09db5a181e39b7fb7d5cfe444b3f1::beep {
    struct BEEP has drop {
        dummy_field: bool,
    }

    fun init(arg0: BEEP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BEEP>(arg0, 6, b"BEEP", b"Road Runner", b" Welcome to the interstellar adventure with Road Runner, where memes meet the moon!  Strap in for a journey filled with laughter, community, and intergalactic gains. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"http://movepump.xyz/uploads/1726529686345_1f723c2eb7df5b0c85e8f7858bee957d_1a9c77adbc.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BEEP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BEEP>>(v1);
    }

    // decompiled from Move bytecode v6
}

