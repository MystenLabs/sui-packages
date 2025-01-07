module 0x2301db4ba2a9e917853620ef4bfb8cc5b4953ae8c113fd7c8a0a2bea2c1a4031::mtai {
    struct MTAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MTAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MTAI>(arg0, 9, b"MTAI", b"Meta AI", b"This is a feature for AI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a0f0b6bc-7840-4ce8-bd54-787624a8a3b0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MTAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MTAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

