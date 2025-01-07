module 0xc8b9d388988841755adb9d9e43f9578190a4af19765cad8cfcb15ae3b0d1b39d::benz {
    struct BENZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: BENZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BENZ>(arg0, 9, b"BENZ", b"MERCEDES ", b"luxury", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a333d24c-9428-4318-a136-6909279910f3.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BENZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BENZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

