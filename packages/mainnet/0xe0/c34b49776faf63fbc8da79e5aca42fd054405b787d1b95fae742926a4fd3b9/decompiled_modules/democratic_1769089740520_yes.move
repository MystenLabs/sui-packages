module 0xe0c34b49776faf63fbc8da79e5aca42fd054405b787d1b95fae742926a4fd3b9::democratic_1769089740520_yes {
    struct DEMOCRATIC_1769089740520_YES has drop {
        dummy_field: bool,
    }

    fun init(arg0: DEMOCRATIC_1769089740520_YES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DEMOCRATIC_1769089740520_YES>(arg0, 0, b"DEMOCRATIC_1769089740520_YES", b"DEMOCRATIC_1769089740520 YES", b"DEMOCRATIC_1769089740520 YES position", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DEMOCRATIC_1769089740520_YES>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DEMOCRATIC_1769089740520_YES>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

