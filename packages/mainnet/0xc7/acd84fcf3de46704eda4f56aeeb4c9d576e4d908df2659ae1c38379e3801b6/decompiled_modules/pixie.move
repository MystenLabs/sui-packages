module 0xc7acd84fcf3de46704eda4f56aeeb4c9d576e4d908df2659ae1c38379e3801b6::pixie {
    struct PIXIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIXIE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<PIXIE>(arg0, 6, b"PIXIE", b"Pixie AI by SuiAI", b"AI generator transforms your ideas into unique, high-quality visuals effortlessly", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/IMG_2134_2a39e32dcc.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PIXIE>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PIXIE>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

