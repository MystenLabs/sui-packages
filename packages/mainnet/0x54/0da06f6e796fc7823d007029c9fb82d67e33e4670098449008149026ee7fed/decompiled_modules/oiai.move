module 0x540da06f6e796fc7823d007029c9fb82d67e33e4670098449008149026ee7fed::oiai {
    struct OIAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: OIAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OIAI>(arg0, 6, b"OIAI", b"OiAi", x"5468697320697320612070726f6d6f74696f6e616c2070756d7020746f6b656e2028415454454e54494f4e20646f206e6f742062757929200a54686520667574757265206973204f694169200a5468697320697320612070726f6d6f74696f6e616c2070756d7020746f6b656e2e20444f204e4f54204255592e2e21200a4f6666696369616c204f69416920746f6b656e203078353934326237333366333833316461313431613033613031656636626232306238303539306630636330373831333533393563623733303736633939643633383a3a6f6961693a3a4f494149", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000000156_7a658e2e06.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OIAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OIAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

