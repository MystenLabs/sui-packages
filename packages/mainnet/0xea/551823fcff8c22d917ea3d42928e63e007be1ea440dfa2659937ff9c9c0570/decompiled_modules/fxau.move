module 0xea551823fcff8c22d917ea3d42928e63e007be1ea440dfa2659937ff9c9c0570::fxau {
    struct FXAU has drop {
        dummy_field: bool,
    }

    fun init(arg0: FXAU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FXAU>(arg0, 9, b"FXAU", b"Fake Gold", b"Fake Gold token for testing", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<FXAU>>(0x2::coin::mint<FXAU>(&mut v2, 100000000000000000, arg1), @0x1d92520c51971dcdb52fed9d191a8d30a29c5138d3995a50dc54ba3f38a821d2);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FXAU>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FXAU>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

