module 0x2239c88202e6f9e8859d55d21d3be0176ca566f50401c444a996d156e4888a37::birb {
    struct BIRB has drop {
        dummy_field: bool,
    }

    fun init(arg0: BIRB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BIRB>(arg0, 6, b"BIRB", b"Sui Birb", x"444f204e4f542046414c4c20464f5220414e5920244249524220434f494e5320594f55204d4159205345450a54656c656772616d2068747470733a2f2f742e6d652f424952426f6e5355490a582068747470733a2f2f782e636f6d2f42495242535549", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241224_080553_aa8e70a76b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BIRB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BIRB>>(v1);
    }

    // decompiled from Move bytecode v6
}

