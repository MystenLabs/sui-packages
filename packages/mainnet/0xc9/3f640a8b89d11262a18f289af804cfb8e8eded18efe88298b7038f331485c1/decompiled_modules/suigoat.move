module 0xc93f640a8b89d11262a18f289af804cfb8e8eded18efe88298b7038f331485c1::suigoat {
    struct SUIGOAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIGOAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIGOAT>(arg0, 6, b"SUIGOAT", b"Sui Gospel of Goatse", b"We serve one master @struth_terminal", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/01_784338164e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIGOAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIGOAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

