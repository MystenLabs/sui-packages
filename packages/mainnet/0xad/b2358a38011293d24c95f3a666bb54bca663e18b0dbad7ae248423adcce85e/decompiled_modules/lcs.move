module 0xadb2358a38011293d24c95f3a666bb54bca663e18b0dbad7ae248423adcce85e::lcs {
    struct LCS has drop {
        dummy_field: bool,
    }

    fun init(arg0: LCS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LCS>(arg0, 6, b"LCS", b"Lucky Coin SUI", b"With the lucky coin of the SUI blockchain network you will bring a lot of luck to your life, buy some and receive hope, faith, love and a lot of financial prosperity, be sure to acquire a little luck! Save your $LCS and protect yourself against negat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732119871011.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LCS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LCS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

