module 0xcab62e435b623ff5862b309c1e4ec14a51432ab1560c30cea4ba72990ebf6854::memetrump {
    struct MEMETRUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEMETRUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEMETRUMP>(arg0, 6, b"MEMEtrump", b"$MEMEtrump", b"Trump Memecoin on #Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731015299755.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MEMETRUMP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEMETRUMP>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

