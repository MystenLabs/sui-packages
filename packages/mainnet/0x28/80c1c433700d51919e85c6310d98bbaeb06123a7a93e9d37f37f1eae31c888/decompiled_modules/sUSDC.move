module 0x2880c1c433700d51919e85c6310d98bbaeb06123a7a93e9d37f37f1eae31c888::sUSDC {
    struct SUSDC has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUSDC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUSDC>(arg0, 9, b"SY-sUSDC", b"SY scallop sUSDC", b"SY scallop sUSDC", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUSDC>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUSDC>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

