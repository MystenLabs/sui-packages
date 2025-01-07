module 0xa8757ba151af8f5b69d627533373672bafee060e0cf6fe51ffe2d13f153e568b::gran {
    struct GRAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: GRAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GRAN>(arg0, 6, b"GRAN", b"$Sui Gran", x"412067616e67737461206772616e6e7920776974682061206c657468616c20646f7365206f66207361737320616e6420616e20756e72656c656e74696e672070617373696f6e20666f722074686520537569206d656d652065636f73797374656d2e200a57657265206272696e67696e672074686520686170707920686f757273206f66206d656d6520736561736f6e206261636b20616e642074726967676572696e6720746865206e6578742077617665206f66206d656d652063756c747572652e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/y7ka6z_e069c77c6d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GRAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GRAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

