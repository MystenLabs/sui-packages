module 0x9ddae78fcf8db3c53ee78741a4f22cf76c9f280be376100edcebda7a7f2ed119::kuku {
    struct KUKU has drop {
        dummy_field: bool,
    }

    fun init(arg0: KUKU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KUKU>(arg0, 6, b"KUKU", b"Kuku the Penguin", x"54686520436f6d65646963205472697461676f6e6973742c206e6f7720616e204149204368617261637465722e0a537072656164207468652066756e21", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1736758427032.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KUKU>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KUKU>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

