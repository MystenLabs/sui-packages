module 0xc187200b5fce49a5a886c54880ff3f2f023c7a4eac13122f925d58ea1a88c725::buc {
    struct BUC has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUC>(arg0, 9, b"BUC", b"BLUICE", b"BUC, IS A POTENTIAL PROJECT THAT WILL RAISE INDIVIDUALS FROM ZERO TO HERO", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/176d815a-2940-4722-96e5-75d89fbc3499.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BUC>>(v1);
    }

    // decompiled from Move bytecode v6
}

