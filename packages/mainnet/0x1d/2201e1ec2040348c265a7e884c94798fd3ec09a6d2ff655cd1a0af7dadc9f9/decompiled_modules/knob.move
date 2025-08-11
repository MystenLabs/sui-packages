module 0x1d2201e1ec2040348c265a7e884c94798fd3ec09a6d2ff655cd1a0af7dadc9f9::knob {
    struct KNOB has drop {
        dummy_field: bool,
    }

    fun init(arg0: KNOB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KNOB>(arg0, 9, b"KNOB", x"426f6e6be2809973206e657720667269656e642e", x"426f6e6be2809973206e657720667269656e642e207c20576562736974653a2068747470733a2f2f6b6e6f622e646f67207c20547769747465723a2068747470733a2f2f782e636f6d2f4b6e6f62546f6b656e207c2043726561746564206f6e3a2068747470733a2f2f626f6e6b2e66756e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreia4rfkktpbpj6da2i3kme2jaynqqn7dz6obhw2ciockekebttjzhm")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<KNOB>(&mut v2, 1000000000000000000, @0xb0ed1ff98508d0cd74fb515e595ae0879b652d21a6a93eb94a8e707bde83f73b, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KNOB>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KNOB>>(v1);
    }

    // decompiled from Move bytecode v6
}

