module 0xdea966c84d3c109294524b46fe75b9db0460c848677169e1c9eb031eacb1a124::wall {
    struct WALL has drop {
        dummy_field: bool,
    }

    fun init(arg0: WALL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WALL>(arg0, 6, b"WALL", b"WALL MIGH TRUMP", b"MAKE CRYPTO GREAT AGAIN. MY HERO MAGADEMIA is here to MAKE COINS GREAT AGAIN.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Pastel_Aesthetic_Minimalist_Guide_Carousel_Instagram_Post_512_x_512_px_13_27ab435aa4.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WALL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WALL>>(v1);
    }

    // decompiled from Move bytecode v6
}

