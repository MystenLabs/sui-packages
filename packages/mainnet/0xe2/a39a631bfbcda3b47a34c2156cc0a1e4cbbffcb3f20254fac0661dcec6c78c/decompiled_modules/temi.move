module 0xe2a39a631bfbcda3b47a34c2156cc0a1e4cbbffcb3f20254fac0661dcec6c78c::temi {
    struct TEMI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEMI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TEMI>(arg0, 6, b"TEMI", b"Temi The Talented Thrush", x"454d49207468652074616c656e74656420746872757368204f6e200a40537569", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/pkfk_Gxcv_400x400_1061bf2f3c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TEMI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TEMI>>(v1);
    }

    // decompiled from Move bytecode v6
}

