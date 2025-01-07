module 0xdca4f3828786834d2482b78923d402b3a1c9bcabf9a82df1a300d009d7948393::chm3 {
    struct CHM3 has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHM3, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHM3>(arg0, 6, b"CHM3", b"Cheems", b"cheems", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/cheems_meme_68afb81759.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHM3>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHM3>>(v1);
    }

    // decompiled from Move bytecode v6
}

