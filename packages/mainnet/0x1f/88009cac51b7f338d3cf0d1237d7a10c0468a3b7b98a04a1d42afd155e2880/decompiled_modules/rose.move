module 0x1f88009cac51b7f338d3cf0d1237d7a10c0468a3b7b98a04a1d42afd155e2880::rose {
    struct ROSE has drop {
        dummy_field: bool,
    }

    fun init(arg0: ROSE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ROSE>(arg0, 9, b"ROSE", b"FLOWERS", x"496d6167696e6520612062656175746966756c20726f7365207468656d6564206272616e6420746861742063617074757265732074686520657373656e6365206f66206c6f76652c20656c6567616e636520616e642070617373696f6e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/067d3847-d787-41a2-bb1f-be4d05129893.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ROSE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ROSE>>(v1);
    }

    // decompiled from Move bytecode v6
}

