module 0x66fb24d2bd2c45508ed6ee38a773f90ed48d116f33d3886431e630d45e7d3725::chrmsui {
    struct CHRMSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHRMSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHRMSUI>(arg0, 6, b"CHRMSUI", b"SUICHARM", b"Sui chain meme project the pokemon charmander", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000196881_1a805fe5ff.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHRMSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHRMSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

