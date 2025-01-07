module 0x7ada8b56dc900edb4fbb65069d687f7a3bdf6e6f59e764e1f502786bff2a041c::bonki {
    struct BONKI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BONKI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BONKI>(arg0, 6, b"BONKI", b"Bonki Cat", b"Smile with $BonkiCat.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000116669_ca67ed6fe4.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BONKI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BONKI>>(v1);
    }

    // decompiled from Move bytecode v6
}

