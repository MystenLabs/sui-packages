module 0xd44289efe45364796042b1ea44e29ce8ece921717f2a7c899f30f3d8c0e7a49::s {
    struct S has drop {
        dummy_field: bool,
    }

    fun init(arg0: S, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<S>(arg0, 9, b"S", b"Hoa", b"Sksk", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/929e5d71-8213-4c8f-9bd0-c820fc38c4df.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<S>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<S>>(v1);
    }

    // decompiled from Move bytecode v6
}

