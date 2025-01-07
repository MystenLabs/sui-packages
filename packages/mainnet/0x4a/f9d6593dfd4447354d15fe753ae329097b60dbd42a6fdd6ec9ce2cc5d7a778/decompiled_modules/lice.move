module 0x4af9d6593dfd4447354d15fe753ae329097b60dbd42a6fdd6ec9ce2cc5d7a778::lice {
    struct LICE has drop {
        dummy_field: bool,
    }

    fun init(arg0: LICE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LICE>(arg0, 6, b"LICE", b"Lice Ice", b"Lice the 1st Ice Cream Memecoin on Sui blockchain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000019972_c504bd609c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LICE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LICE>>(v1);
    }

    // decompiled from Move bytecode v6
}

