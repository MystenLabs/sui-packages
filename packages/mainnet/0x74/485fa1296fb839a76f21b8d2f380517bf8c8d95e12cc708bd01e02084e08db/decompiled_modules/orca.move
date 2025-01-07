module 0x74485fa1296fb839a76f21b8d2f380517bf8c8d95e12cc708bd01e02084e08db::orca {
    struct ORCA has drop {
        dummy_field: bool,
    }

    fun init(arg0: ORCA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ORCA>(arg0, 6, b"ORCA", b"ORCA ON SUI", b"ORCA ON SUI is the latest addition to the world of meme coins, launching on the fast and scalable SUI Blockchain. Designed to bring fun, engagement, and community-driven growth, ORCA ON SUI is more than just a meme token.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1735492789309.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ORCA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ORCA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

