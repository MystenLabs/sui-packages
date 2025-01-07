module 0xf6f9fbb046466dd9ef0097d902b1eb3ef67064f98741291dd6523eb5d5651f59::rmx {
    struct RMX has drop {
        dummy_field: bool,
    }

    fun init(arg0: RMX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RMX>(arg0, 9, b"RMX", b"Rose Monro", b"Crypto to support Rose Monroe ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/1b1c2724-7034-4e1a-9edd-62ab19142b53.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RMX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RMX>>(v1);
    }

    // decompiled from Move bytecode v6
}

