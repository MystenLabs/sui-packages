module 0x375bbf15be395f7a8d98d66ab741d1fb8409b4fc9ddf98a5e29af6d9c2d31665::strump {
    struct STRUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: STRUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STRUMP>(arg0, 6, b"STRUMP", b" Super Trump", b"Meet New US President : Super President Trump ! The prophecy has been fulfilled! President Super Trump ! Community Driven & Memecoin on SUI. Donald Trump fell to Earth from space in 1946. He served as president of the United States!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731142002287.webp")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<STRUMP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STRUMP>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

