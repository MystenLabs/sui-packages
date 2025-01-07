module 0xb3e448081d6798f14e7242e11010ec2d121d2b54c2077c4f2d5bd94e791b1ca5::moonpop {
    struct MOONPOP has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOONPOP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOONPOP>(arg0, 6, b"MOONPOP", b"MOONPOP SUI", b"Pop Pop Pop Pop", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/wx_ir_ZD_3_400x400_d1f8bcff81.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOONPOP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOONPOP>>(v1);
    }

    // decompiled from Move bytecode v6
}

