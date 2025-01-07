module 0x5b5b26ff980d41db5aee17f1e6a9c59a04d475df107b664d6549652c7e14346d::suiana {
    struct SUIANA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIANA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIANA>(arg0, 6, b"SUIANA", b"SUI Analyzer", b"SUI Analyzer helps you find gems. Avoid junk and scam tokens on Movepump.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suiana_395307a869.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIANA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIANA>>(v1);
    }

    // decompiled from Move bytecode v6
}

