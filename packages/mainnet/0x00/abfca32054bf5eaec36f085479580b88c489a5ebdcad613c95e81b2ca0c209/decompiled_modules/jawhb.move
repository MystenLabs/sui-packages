module 0xabfca32054bf5eaec36f085479580b88c489a5ebdcad613c95e81b2ca0c209::jawhb {
    struct JAWHB has drop {
        dummy_field: bool,
    }

    fun init(arg0: JAWHB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JAWHB>(arg0, 6, b"JAWHB", b"GIT A JAWHB", b"Karen dumb no realize coin is JAWHB", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_0832_ccbf215b2b.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JAWHB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JAWHB>>(v1);
    }

    // decompiled from Move bytecode v6
}

