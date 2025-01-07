module 0x8d728d1eca21c78150ff3d9fad3a99229a7bad8040c254937daf86e17e6498b2::gsdfsafdsf {
    struct GSDFSAFDSF has drop {
        dummy_field: bool,
    }

    fun init(arg0: GSDFSAFDSF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GSDFSAFDSF>(arg0, 9, b"GSDFSAFDSF", b"dfsdfsdfsd", b"fgdfgsdfgdfg", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/db8510c3-996d-4aa6-9a17-2a9f5784e3f8.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GSDFSAFDSF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GSDFSAFDSF>>(v1);
    }

    // decompiled from Move bytecode v6
}

