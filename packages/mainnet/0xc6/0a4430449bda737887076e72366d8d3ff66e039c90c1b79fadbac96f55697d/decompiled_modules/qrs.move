module 0xc60a4430449bda737887076e72366d8d3ff66e039c90c1b79fadbac96f55697d::qrs {
    struct QRS has drop {
        dummy_field: bool,
    }

    fun init(arg0: QRS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<QRS>(arg0, 6, b"QRS", b"Quadrobers", b"The Quadrobers society token of good people", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/cat_Mask_Black_50e9162ce4.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<QRS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<QRS>>(v1);
    }

    // decompiled from Move bytecode v6
}

