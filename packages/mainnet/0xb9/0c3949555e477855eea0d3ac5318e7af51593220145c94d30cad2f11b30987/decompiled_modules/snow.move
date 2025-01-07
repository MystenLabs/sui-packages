module 0xb90c3949555e477855eea0d3ac5318e7af51593220145c94d30cad2f11b30987::snow {
    struct SNOW has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNOW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SNOW>(arg0, 6, b"Snow", b"Sui Snowman", b"Sui Snowman embodies an eagerly awaited $Snow Token on @Turbos_finance with remarkable utilities.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731230228311.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SNOW>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SNOW>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

