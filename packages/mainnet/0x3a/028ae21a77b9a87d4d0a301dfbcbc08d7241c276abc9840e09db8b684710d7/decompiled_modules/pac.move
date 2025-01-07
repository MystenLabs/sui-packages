module 0x3a028ae21a77b9a87d4d0a301dfbcbc08d7241c276abc9840e09db8b684710d7::pac {
    struct PAC has drop {
        dummy_field: bool,
    }

    fun init(arg0: PAC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PAC>(arg0, 6, b"PAC", b"Pac", b"Study Elon Musk, Study $PAC.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Image_1729093623160_e43633b0c4.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PAC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PAC>>(v1);
    }

    // decompiled from Move bytecode v6
}

