module 0x34c0049f4dce77a858feed9c1f3966f9e63f1283863c92540c14776061bf45a1::code {
    struct CODE has drop {
        dummy_field: bool,
    }

    fun init(arg0: CODE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CODE>(arg0, 6, b"CODE", b"CODECOIN", b"CODE ON SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/7_S_Ppm0_U8_400x400_402fdeb052.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CODE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CODE>>(v1);
    }

    // decompiled from Move bytecode v6
}

