module 0xe8e56293f95170d1afdef13541233114dd0b14b8467019feeec0bc39288107f2::cros {
    struct CROS has drop {
        dummy_field: bool,
    }

    fun init(arg0: CROS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CROS>(arg0, 9, b"CROS", b"Cros", b"Uptrending is the goal", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/2c6fae4b-c90d-471f-8bab-74cb6f4181ff.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CROS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CROS>>(v1);
    }

    // decompiled from Move bytecode v6
}

