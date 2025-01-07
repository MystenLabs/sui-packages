module 0xcb7c325406bbb8f1e23d5fa8a48e01eda0ce775071b387a3dbc52f56ec2da3a4::msh {
    struct MSH has drop {
        dummy_field: bool,
    }

    fun init(arg0: MSH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MSH>(arg0, 9, b"MSH", b"meteor sho", b"meteor shower", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/19bd2cc1-e0c2-41b3-900f-469ea3d88f02.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MSH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MSH>>(v1);
    }

    // decompiled from Move bytecode v6
}

