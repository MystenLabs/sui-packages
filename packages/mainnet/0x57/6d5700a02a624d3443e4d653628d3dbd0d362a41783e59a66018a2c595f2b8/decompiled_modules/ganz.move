module 0x576d5700a02a624d3443e4d653628d3dbd0d362a41783e59a66018a2c595f2b8::ganz {
    struct GANZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: GANZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GANZ>(arg0, 9, b"GANZ", b"Gan-z", b"Generation zoomer", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/95c9d9b8-3d0e-44bc-b3b2-1a18be9a42a7.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GANZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GANZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

