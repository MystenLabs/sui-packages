module 0x29942503a30271ecdba154236c6e9c0b194b363cb93fcf3faca2774e461ad1c5::l286 {
    struct L286 has drop {
        dummy_field: bool,
    }

    fun init(arg0: L286, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<L286>(arg0, 6, b"L286", b"286", x"323836200a2346726565204c75696769", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/download_3fe9d57db2.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<L286>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<L286>>(v1);
    }

    // decompiled from Move bytecode v6
}

