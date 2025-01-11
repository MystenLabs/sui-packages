module 0x3a4fd983a10ac6c2d9c84b6d49cd6121bdb8faddc24c607ef38130d32a235db7::suidman {
    struct SUIDMAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIDMAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIDMAN>(arg0, 6, b"SUIDMAN", b"SUIDERMAN", b"Peter Perker as autistic spiderman is hitting sui chain. He sticks to the market and never letting it go", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_7643_5afc287151.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIDMAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIDMAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

