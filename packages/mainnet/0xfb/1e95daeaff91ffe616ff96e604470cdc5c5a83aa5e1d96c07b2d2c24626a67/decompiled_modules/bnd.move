module 0xfb1e95daeaff91ffe616ff96e604470cdc5c5a83aa5e1d96c07b2d2c24626a67::bnd {
    struct BND has drop {
        dummy_field: bool,
    }

    fun init(arg0: BND, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BND>(arg0, 9, b"BND", b"GNJ", b"JB", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/47232cd6-50e9-4c71-9078-74feed8f9445.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BND>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BND>>(v1);
    }

    // decompiled from Move bytecode v6
}

