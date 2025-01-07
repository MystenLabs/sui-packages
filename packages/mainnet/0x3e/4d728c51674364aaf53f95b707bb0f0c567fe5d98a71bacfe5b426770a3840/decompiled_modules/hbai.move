module 0x3e4d728c51674364aaf53f95b707bb0f0c567fe5d98a71bacfe5b426770a3840::hbai {
    struct HBAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: HBAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HBAI>(arg0, 6, b"HBAI", b"HexaBrainAI", b"HexaBrainAI is an innovative crypto-powered project that merges the realms of artificial intelligence and blockchain technology. At its core, HexaBrainAI is a dynamic AI bot designed to deliver unique, creative, and thought-provoking phrases, tailore", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1736082982297.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HBAI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HBAI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

