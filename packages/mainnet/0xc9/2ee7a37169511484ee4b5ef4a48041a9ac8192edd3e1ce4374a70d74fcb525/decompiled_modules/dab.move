module 0xc92ee7a37169511484ee4b5ef4a48041a9ac8192edd3e1ce4374a70d74fcb525::dab {
    struct DAB has drop {
        dummy_field: bool,
    }

    fun init(arg0: DAB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DAB>(arg0, 6, b"DAB", b"Dabbing Turtle", b"No socials, no tg, just a turtle dabbing to dex.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_0008_65a0ac55e6.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DAB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DAB>>(v1);
    }

    // decompiled from Move bytecode v6
}

