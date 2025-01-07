module 0x58536bdf72558e880dd41bf2fddee320a89801615e1c708a06fe4ae502d42235::dxr {
    struct DXR has drop {
        dummy_field: bool,
    }

    fun init(arg0: DXR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DXR>(arg0, 9, b"DXR", b"Dxster", b"Dxster coin is a cryptocurrency inspired by internet memes or popular culture trends.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3808fa5a-7a1d-42ac-a8bf-2e1e127e3c54.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DXR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DXR>>(v1);
    }

    // decompiled from Move bytecode v6
}

