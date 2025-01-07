module 0xb7c8307c5edd5e4cae369da692a9476fb4fbee139bbd5a3f34143e2575095d2d::young {
    struct YOUNG has drop {
        dummy_field: bool,
    }

    fun init(arg0: YOUNG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YOUNG>(arg0, 6, b"YOUNG", b"Young Neiro", x"4c6f6e67206265666f7265204e4549524f20626563616d6520746865206c6567656e64206f6620746865206d656d65636f696e20776f726c642c207468657265207761732024594f554e47204e4549524f20612073706972697465642c20706c617966756c206669677572652066756c6c206f6620656e6572677920616e6420626f756e646c65737320637572696f736974792e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/u1pmt_B_Aq_400x400_f00ba80027.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YOUNG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<YOUNG>>(v1);
    }

    // decompiled from Move bytecode v6
}

