module 0x5f10ed656714f05f65667595c86b66ab4319927e45cf8882ec6a6fd9f4e23b4f::ozien {
    struct OZIEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: OZIEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OZIEN>(arg0, 6, b"OZIEN", b"Ozeins sui", b"Ozienba", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreie7l3krkiewqioyhgken3vdongie3uwhmnapcvvap7obvbh3gki3m")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OZIEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<OZIEN>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

