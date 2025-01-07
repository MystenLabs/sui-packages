module 0x61b3c74c4198d83f99e6ff1783ee5ce13d11aaaac4cbbc97b0fddb7af04ab21f::quacko {
    struct QUACKO has drop {
        dummy_field: bool,
    }

    fun init(arg0: QUACKO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<QUACKO>(arg0, 6, b"QUACKO", b"Quacko On sui", b"Quacko is meme coin with no intrinsic value or excpectation of financial return", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000017690_13402ea747.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<QUACKO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<QUACKO>>(v1);
    }

    // decompiled from Move bytecode v6
}

