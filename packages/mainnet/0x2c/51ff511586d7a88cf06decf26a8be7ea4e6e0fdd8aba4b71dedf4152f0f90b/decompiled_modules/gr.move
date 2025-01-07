module 0x2c51ff511586d7a88cf06decf26a8be7ea4e6e0fdd8aba4b71dedf4152f0f90b::gr {
    struct GR has drop {
        dummy_field: bool,
    }

    fun init(arg0: GR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GR>(arg0, 9, b"GR", b"RG", b"DSF", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/6bf4861f-5dcb-4a21-8b96-73ce26b26e43.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GR>>(v1);
    }

    // decompiled from Move bytecode v6
}

