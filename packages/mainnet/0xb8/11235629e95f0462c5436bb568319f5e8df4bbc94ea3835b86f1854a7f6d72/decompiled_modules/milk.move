module 0xb811235629e95f0462c5436bb568319f5e8df4bbc94ea3835b86f1854a7f6d72::milk {
    struct MILK has drop {
        dummy_field: bool,
    }

    fun init(arg0: MILK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MILK>(arg0, 9, b"MILK", b"OCO", b"No matter ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8fc26361-9d02-4bbd-80f8-e4973978a942.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MILK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MILK>>(v1);
    }

    // decompiled from Move bytecode v6
}

