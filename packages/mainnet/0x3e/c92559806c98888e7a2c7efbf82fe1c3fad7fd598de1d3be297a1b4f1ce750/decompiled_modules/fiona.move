module 0x3ec92559806c98888e7a2c7efbf82fe1c3fad7fd598de1d3be297a1b4f1ce750::fiona {
    struct FIONA has drop {
        dummy_field: bool,
    }

    fun init(arg0: FIONA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FIONA>(arg0, 6, b"FIONA", b"Fiona SUI", b"Fiona the World-Famous Hippo is on the way to conquer sui chain!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/images_9d6ee2003c.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FIONA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FIONA>>(v1);
    }

    // decompiled from Move bytecode v6
}

