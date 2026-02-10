module 0xe1fc84c1e8c8ecc68ae1bf5f28c33b037a75285ce6eff4226264db7110fd25d9::hbtsui {
    struct HBTSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: HBTSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HBTSUI>(arg0, 9, b"HBTSUI", b"HeartbeatSui", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HBTSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<HBTSUI>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

