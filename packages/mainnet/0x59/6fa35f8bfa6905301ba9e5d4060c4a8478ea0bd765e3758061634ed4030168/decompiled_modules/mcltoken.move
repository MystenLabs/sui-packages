module 0x596fa35f8bfa6905301ba9e5d4060c4a8478ea0bd765e3758061634ed4030168::mcltoken {
    struct MCLTOKEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: MCLTOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MCLTOKEN>(arg0, 6, b"MCLtoken", b"Michelin", b"https://app.turbos.finance/#/trade?input=0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC&output=0x2::sui::SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/2532545f_b552_4a3b_8fec_9004e81bf317_c7e8f545f1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MCLTOKEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MCLTOKEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

