module 0x2c8e236ca3c96d3b72edd3ce0a1fc879d7b1cae9489b49a027d85fff9e8cb276::magas {
    struct MAGAS has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAGAS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAGAS>(arg0, 9, b"MAGAS", b"Maga", b"Maga will be 1b cap", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/419737c4-343c-4fab-a83d-35947ef1f007.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAGAS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MAGAS>>(v1);
    }

    // decompiled from Move bytecode v6
}

