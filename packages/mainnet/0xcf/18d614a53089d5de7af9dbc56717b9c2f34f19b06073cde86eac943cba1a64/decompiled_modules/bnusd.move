module 0xcf18d614a53089d5de7af9dbc56717b9c2f34f19b06073cde86eac943cba1a64::bnusd {
    struct BNUSD has drop {
        dummy_field: bool,
    }

    fun init(arg0: BNUSD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BNUSD>(arg0, 9, b"bnUSD", b"Balanced Dollar", b"A stable coin issued by Balanced", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://raw.githubusercontent.com/balancednetwork/assets/master/blockchains/icon/assets/cx88fd7df7ddff82f7cc735c871dc519838cb235bb/logo.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BNUSD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BNUSD>>(v1);
    }

    // decompiled from Move bytecode v6
}

