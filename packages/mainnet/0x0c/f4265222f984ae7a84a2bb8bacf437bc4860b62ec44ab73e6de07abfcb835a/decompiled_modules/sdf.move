module 0xcf4265222f984ae7a84a2bb8bacf437bc4860b62ec44ab73e6de07abfcb835a::sdf {
    struct SDF has drop {
        dummy_field: bool,
    }

    fun init(arg0: SDF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SDF>(arg0, 9, b"SDF", b"FD", b"SDFCX", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/9e0fd591-f52e-4bb0-9f55-5cce2fddb290.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SDF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SDF>>(v1);
    }

    // decompiled from Move bytecode v6
}

