module 0x7d030e6df88c1215755381f9b2f9ab207637826e343468d5627c0d84bd112913::godl {
    struct GODL has drop {
        dummy_field: bool,
    }

    fun init(arg0: GODL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GODL>(arg0, 9, b"GODL", b"Smartnonny", b"Governance token ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/fc3c3233-cf4e-40ac-87f9-30f10e1ae3f4.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GODL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GODL>>(v1);
    }

    // decompiled from Move bytecode v6
}

