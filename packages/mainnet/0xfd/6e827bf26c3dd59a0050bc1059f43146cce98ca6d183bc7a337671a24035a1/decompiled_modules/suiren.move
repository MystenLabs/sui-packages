module 0xfd6e827bf26c3dd59a0050bc1059f43146cce98ca6d183bc7a337671a24035a1::suiren {
    struct SUIREN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIREN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIREN>(arg0, 6, b"SUIREN", b"Sui Siren", x"53756920536972656e20282453554952454e292069732063616c6c696e672066726f6d20746865206465657020776174657273206f662074686520537569204e6574776f726b2e204c7572696e6720696e2074686520627261766520616e6420626f6c642e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/PP_ec68c5bcf6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIREN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIREN>>(v1);
    }

    // decompiled from Move bytecode v6
}

