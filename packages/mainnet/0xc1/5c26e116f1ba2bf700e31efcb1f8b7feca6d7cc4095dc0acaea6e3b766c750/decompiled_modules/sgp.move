module 0xc15c26e116f1ba2bf700e31efcb1f8b7feca6d7cc4095dc0acaea6e3b766c750::sgp {
    struct SGP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SGP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SGP>(arg0, 6, b"SGP", b"Sui Guard Protection", b"SGP - Security of digital assets on the sui network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731605756755.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SGP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SGP>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

