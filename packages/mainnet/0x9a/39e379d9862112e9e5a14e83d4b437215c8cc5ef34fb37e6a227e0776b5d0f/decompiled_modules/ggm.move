module 0x9a39e379d9862112e9e5a14e83d4b437215c8cc5ef34fb37e6a227e0776b5d0f::ggm {
    struct GGM has drop {
        dummy_field: bool,
    }

    fun init(arg0: GGM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GGM>(arg0, 6, b"GgM", b"Me band x ", b"Coin bxbd dbs dbs d", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730512775956.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GGM>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GGM>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

