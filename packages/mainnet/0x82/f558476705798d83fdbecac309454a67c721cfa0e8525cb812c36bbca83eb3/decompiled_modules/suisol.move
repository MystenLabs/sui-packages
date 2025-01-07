module 0x82f558476705798d83fdbecac309454a67c721cfa0e8525cb812c36bbca83eb3::suisol {
    struct SUISOL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUISOL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUISOL>(arg0, 6, b"SUISOL", b"Sui vs Sol", b"as above so below", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/image_10_8afc20319c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUISOL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUISOL>>(v1);
    }

    // decompiled from Move bytecode v6
}

