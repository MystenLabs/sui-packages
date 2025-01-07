module 0x4f0ff08dbf740d533ef09d7077156ccd0c36e087cde5772e846b2d1642c8c5c1::dgg {
    struct DGG has drop {
        dummy_field: bool,
    }

    fun init(arg0: DGG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DGG>(arg0, 6, b"Dgg", b"Gu", b"Dc", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000010692_2a81a6b518.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DGG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DGG>>(v1);
    }

    // decompiled from Move bytecode v6
}

