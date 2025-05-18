module 0xbccf3ed7b0339c896bc099bd239fc7f731baba8349329ad50530d520a49af2f7::loas {
    struct LOAS has drop {
        dummy_field: bool,
    }

    fun init(arg0: LOAS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LOAS>(arg0, 6, b"LOAS", b"loster", b"lose ss sss sss star", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreia5qpdccxcdfnvlh75vpl526mf5xt23hbt2dhli4dfc6iventbgku")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LOAS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<LOAS>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

