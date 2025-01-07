module 0x6d3afa6d6425eb76b5ddf1a89c7ed9d964c04a5a706c36a4c93c58515e646087::haggis {
    struct HAGGIS has drop {
        dummy_field: bool,
    }

    fun init(arg0: HAGGIS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HAGGIS>(arg0, 6, b"HAGGIS", b"Haggis Hippo", b"A tiny Endangered pygmy hippo calf Haggis has been born at Edinburgh Zoo!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/WQ_0_Q2_W6_Y_400x400_d9d3f9199c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HAGGIS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HAGGIS>>(v1);
    }

    // decompiled from Move bytecode v6
}

