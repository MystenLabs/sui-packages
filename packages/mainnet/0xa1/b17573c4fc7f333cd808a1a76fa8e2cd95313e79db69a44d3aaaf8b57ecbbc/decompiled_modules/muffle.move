module 0xa1b17573c4fc7f333cd808a1a76fa8e2cd95313e79db69a44d3aaaf8b57ecbbc::muffle {
    struct MUFFLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: MUFFLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MUFFLE>(arg0, 6, b"Muffle", b"MUFFLE", b"Mufflemouth (MUFFLE) Pepe best friend in first ever official pepe animation! Matt Furie patreon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/muffle_ae3c420865.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MUFFLE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MUFFLE>>(v1);
    }

    // decompiled from Move bytecode v6
}

