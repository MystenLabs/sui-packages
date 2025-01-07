module 0xf438c7860b84287437e32f369a884a45fffdfe6e1cb89c999650d26f3a3cba5e::mpepe {
    struct MPEPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: MPEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MPEPE>(arg0, 6, b"MPEPE", b"Mpepe", b"Introducing MPEPE, the revolutionary meme cryptocurrency at the intersection of sports fandom and blockchain innovation.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/mpepegif_1_5a7ad7b93e.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MPEPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MPEPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

