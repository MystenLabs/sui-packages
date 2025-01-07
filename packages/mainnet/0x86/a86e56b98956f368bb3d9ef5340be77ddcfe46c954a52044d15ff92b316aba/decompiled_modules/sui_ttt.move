module 0x86a86e56b98956f368bb3d9ef5340be77ddcfe46c954a52044d15ff92b316aba::sui_ttt {
    struct SUI_TTT has drop {
        dummy_field: bool,
    }

    fun create_currency<T0: drop>(arg0: T0, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::TreasuryCap<T0> {
        let (v0, v1) = 0x2::coin::create_currency<T0>(arg0, 6, b"Suit", b"SUIT", b"SUIT Token showcases", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d3hnfqimznafg0.cloudfront.net/image-handler/ts/20200218065624/ri/950/src/images/Article_Images/ImageForArticle_227_15820269818147731.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<T0>>(v1);
        v0
    }

    fun init(arg0: SUI_TTT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = create_currency<SUI_TTT>(arg0, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUI_TTT>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SUI_TTT>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SUI_TTT>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

