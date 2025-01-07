module 0x64f7ab82a266847a7a9d78270eaea2af9cfdefa102088d8ec78178205e8ec7de::popolar {
    struct POPOLAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: POPOLAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POPOLAR>(arg0, 6, b"POPOLAR", b"Po the Polar", b"Hi, I`m Po. I`m a big goofy Polar Bear that always seems to fumble his bags. Some call me the Pengue killer, but honestly, I prefer seals. Website: https://www.pothepolar.xyz/ Twitter/x: https://x.com/PoThePolarSol Telegram: https://t.me/pothepolar", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/234243523456_31f2ea41cd.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POPOLAR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POPOLAR>>(v1);
    }

    // decompiled from Move bytecode v6
}

