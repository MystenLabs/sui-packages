module 0x2c4a7c2fd7a2aca3890a7835370b363700ac58f9b70927eef97630550e0a378f::dooom {
    struct DOOOM has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOOOM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOOOM>(arg0, 6, b"DOOOM", b"DOOM", b"Doom PlayToEarn is a thrilling play-to-earn (P2E) crypto game inspired by the classic \"Doom\" aesthetic, where players can immerse themselves in an apocalyptic world filled with challenges, battles, and quests. Players earn cryptocurrency rewards by participating in battles, completing missions, and trading in-game assets.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_7559_afbce9ffd2.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOOOM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOOOM>>(v1);
    }

    // decompiled from Move bytecode v6
}

