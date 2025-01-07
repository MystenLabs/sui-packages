module 0x73405ba9f62fa82d03961a64e14c3e6ba4a955536850b6480849ff20368df1d4::sfrog {
    struct SFROG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SFROG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SFROG>(arg0, 6, b"SFROG", b"Sui Frog", b"$SFROG is a fun blue frog-themed meme token recently launched on the Sui Network.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/image_fx_3_a6882d7cca.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SFROG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SFROG>>(v1);
    }

    // decompiled from Move bytecode v6
}

