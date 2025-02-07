module 0xed61df2f798831eb00cefdf84b5fa6bb5d5d9e05baf4e2df25fb31bfae102ffd::apple {
    struct APPLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: APPLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<APPLE>(arg0, 6, b"APPLE", b"OFFICIAL APPLE", b"MEME", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/R_a_ae_337c89ac84.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<APPLE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<APPLE>>(v1);
    }

    // decompiled from Move bytecode v6
}

