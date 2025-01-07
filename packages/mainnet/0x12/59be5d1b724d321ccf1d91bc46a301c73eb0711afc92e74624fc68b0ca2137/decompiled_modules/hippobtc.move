module 0x1259be5d1b724d321ccf1d91bc46a301c73eb0711afc92e74624fc68b0ca2137::hippobtc {
    struct HIPPOBTC has drop {
        dummy_field: bool,
    }

    fun init(arg0: HIPPOBTC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HIPPOBTC>(arg0, 6, b"HIPPOBTC", b"HIPPO BTC", x"484950504f4254430a426573742043727970746f202b2042657374204d656d65", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/3_D_Animation_Style_Create_an_hippo_that_invest_in_bitcoin_0_e4d4bc5507.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HIPPOBTC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HIPPOBTC>>(v1);
    }

    // decompiled from Move bytecode v6
}

