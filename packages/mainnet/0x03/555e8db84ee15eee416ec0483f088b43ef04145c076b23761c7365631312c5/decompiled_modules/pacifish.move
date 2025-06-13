module 0x3555e8db84ee15eee416ec0483f088b43ef04145c076b23761c7365631312c5::pacifish {
    struct PACIFISH has drop {
        dummy_field: bool,
    }

    fun init(arg0: PACIFISH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PACIFISH>(arg0, 6, b"PACIFISH", b"Pacifish on Sui", b"Dive with PACIFISH", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreifvfgehajbbd7qwuomemblsj3pdasmn2wzmlqzvlcta5cl54eqrwy")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PACIFISH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PACIFISH>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

