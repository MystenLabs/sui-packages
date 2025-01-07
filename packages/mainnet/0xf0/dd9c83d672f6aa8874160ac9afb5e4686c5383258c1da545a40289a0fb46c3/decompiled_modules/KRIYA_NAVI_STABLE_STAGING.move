module 0xf0dd9c83d672f6aa8874160ac9afb5e4686c5383258c1da545a40289a0fb46c3::KRIYA_NAVI_STABLE_STAGING {
    struct KRIYA_NAVI_STABLE_STAGING has drop {
        dummy_field: bool,
    }

    fun init(arg0: KRIYA_NAVI_STABLE_STAGING, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KRIYA_NAVI_STABLE_STAGING>(arg0, 6, b"KRIYA_NAVI_STABLE_STAGING", b"KRIYA_NAVI_STABLE_STAGING", b"staging kriya navi usdc-usdt leveraged lending token.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://assets.coingecko.com/coins/images/29850/standard/pepe-token.jpeg?1696528776"))), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KRIYA_NAVI_STABLE_STAGING>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KRIYA_NAVI_STABLE_STAGING>>(v1);
    }

    // decompiled from Move bytecode v6
}

