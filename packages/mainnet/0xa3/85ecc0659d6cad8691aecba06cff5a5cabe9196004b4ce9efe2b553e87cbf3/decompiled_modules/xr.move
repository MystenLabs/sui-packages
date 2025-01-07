module 0xa385ecc0659d6cad8691aecba06cff5a5cabe9196004b4ce9efe2b553e87cbf3::xr {
    struct XR has drop {
        dummy_field: bool,
    }

    fun init(arg0: XR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XR>(arg0, 9, b"XR", b"XRADERS", b"Providing actionable insights to users, enhancing trading experience. $XR", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/9dd60966-f78a-4ee9-a64b-793afa42a188.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<XR>>(v1);
    }

    // decompiled from Move bytecode v6
}

