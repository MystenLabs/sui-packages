module 0x1575d680c5b643c6423afd829c5128844d139382951c84edfe327cac3e9c5c0b::shibai {
    struct SHIBAI has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SHIBAI>, arg1: 0x2::coin::Coin<SHIBAI>) {
        0x2::coin::burn<SHIBAI>(arg0, arg1);
    }

    fun init(arg0: SHIBAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHIBAI>(arg0, 2, b"SHIBAI", b"SUIB", b"https://aishibaog.xyz/static/media/logo.adf6243f.png", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SHIBAI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHIBAI>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SHIBAI>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SHIBAI>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

