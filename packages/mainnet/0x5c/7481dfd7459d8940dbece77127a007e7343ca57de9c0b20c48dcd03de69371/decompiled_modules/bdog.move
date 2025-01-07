module 0x5c7481dfd7459d8940dbece77127a007e7343ca57de9c0b20c48dcd03de69371::bdog {
    struct BDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: BDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BDOG>(arg0, 6, b"BDog", b"Brians Dog", b"Brian Armstrongs Dog", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20241009_180558_faf6a5925c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BDOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BDOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

