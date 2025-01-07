module 0x50b8a72e5f215ba5db8e75b28c0725ca9d9f8872dbd283f8ada147aec0065b59::col {
    struct COL has drop {
        dummy_field: bool,
    }

    fun init(arg0: COL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COL>(arg0, 6, b"COL", b"Cologne", b"Cologne makes you smell irresistible.grab a bottle of cologne and let it work its magic.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/OIG_3_6_39571396a0.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<COL>>(v1);
    }

    // decompiled from Move bytecode v6
}

