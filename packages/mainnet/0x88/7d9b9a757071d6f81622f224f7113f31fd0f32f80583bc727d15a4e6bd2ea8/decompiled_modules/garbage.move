module 0x887d9b9a757071d6f81622f224f7113f31fd0f32f80583bc727d15a4e6bd2ea8::garbage {
    struct GARBAGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: GARBAGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GARBAGE>(arg0, 6, b"GARBAGE", b"Garbage", b"Go!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/34_D3970_E_D043_4_DA_7_A394_DA_4_C656_B7_D0_C_75865c7cf1.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GARBAGE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GARBAGE>>(v1);
    }

    // decompiled from Move bytecode v6
}

