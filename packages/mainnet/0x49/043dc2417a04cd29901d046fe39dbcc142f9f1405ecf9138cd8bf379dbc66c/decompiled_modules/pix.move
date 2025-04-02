module 0x49043dc2417a04cd29901d046fe39dbcc142f9f1405ecf9138cd8bf379dbc66c::pix {
    struct PIX has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PIX>(arg0, 6, b"PIX", b"PIXELS", b"Make your home in a world of unlimited adventure. Master skills and play with friends. Build new communities.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/pixel_logo_031d789a31.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PIX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PIX>>(v1);
    }

    // decompiled from Move bytecode v6
}

