module 0x2f689dd26d2b55fe95735ed9459e60da5302ee061c1506863e1ff24a4c06e82c::nacho {
    struct NACHO has drop {
        dummy_field: bool,
    }

    fun init(arg0: NACHO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NACHO>(arg0, 6, b"NACHO", b"NACHO SUI", b"Life is good. Real good!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_7280_0831efdb49.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NACHO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NACHO>>(v1);
    }

    // decompiled from Move bytecode v6
}

