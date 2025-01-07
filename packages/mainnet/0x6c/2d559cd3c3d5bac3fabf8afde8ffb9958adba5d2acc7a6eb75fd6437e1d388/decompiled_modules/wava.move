module 0x6c2d559cd3c3d5bac3fabf8afde8ffb9958adba5d2acc7a6eb75fd6437e1d388::wava {
    struct WAVA has drop {
        dummy_field: bool,
    }

    fun init(arg0: WAVA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WAVA>(arg0, 9, b"WAVA", b"Wave wall", b"dont love me", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7f092a97-df4b-4763-a217-acb5b1e5d50f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WAVA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WAVA>>(v1);
    }

    // decompiled from Move bytecode v6
}

