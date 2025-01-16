module 0x6ba774d6826350a5a1e33b370293f0a843470f0025f2296e6b8d9fb795aaa650::kitsui {
    struct KITSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: KITSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KITSUI>(arg0, 6, b"KITSUI", b"Kitsui Meme", b"Hi, Im KITSUI, the chillest cat on SUI! With my squad of cat lovers, were redefining vibes and taking it easy. HOLD and everyone will know how cool I am!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/cat_073b335753.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KITSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KITSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

