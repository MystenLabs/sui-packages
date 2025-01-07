module 0xdfc91db361161281fb0328b30e04b694b68304e270a0749c7a82ba3d1997eb16::huocoin {
    struct HUOCOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: HUOCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HUOCOIN>(arg0, 6, b"HUO", b"Huo Doge", b"Huo Doge is the first fiery dog token as a dichotomy to the Sui ecosystem. By and for fans of Sui Defi", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.ibb.co/ZTznQg6/SWI.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HUOCOIN>>(v1);
        0x2::coin::mint_and_transfer<HUOCOIN>(&mut v2, 1000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HUOCOIN>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

