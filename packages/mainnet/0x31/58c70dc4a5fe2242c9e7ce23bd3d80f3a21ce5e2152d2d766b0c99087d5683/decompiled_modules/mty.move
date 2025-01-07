module 0x3158c70dc4a5fe2242c9e7ce23bd3d80f3a21ce5e2152d2d766b0c99087d5683::mty {
    struct MTY has drop {
        dummy_field: bool,
    }

    fun init(arg0: MTY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MTY>(arg0, 9, b"MTY", b"Empty", b"Empty description", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/75a666ec-fffc-439d-a028-ac8f5b27d528.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MTY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MTY>>(v1);
    }

    // decompiled from Move bytecode v6
}

