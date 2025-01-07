module 0x6ae00a7168f3041d54a9b656d1f28f98610ae94adb10d86e918cad38db9ad6a4::wpp {
    struct WPP has drop {
        dummy_field: bool,
    }

    fun init(arg0: WPP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WPP>(arg0, 9, b"WPP", b"AYUD", b"WEWEPUMP", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/62fbb373-98db-4c66-8c8d-7426b82381d0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WPP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WPP>>(v1);
    }

    // decompiled from Move bytecode v6
}

