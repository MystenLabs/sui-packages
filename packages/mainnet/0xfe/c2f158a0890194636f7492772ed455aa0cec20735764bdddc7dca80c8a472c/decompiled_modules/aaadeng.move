module 0xfec2f158a0890194636f7492772ed455aa0cec20735764bdddc7dca80c8a472c::aaadeng {
    struct AAADENG has drop {
        dummy_field: bool,
    }

    fun init(arg0: AAADENG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AAADENG>(arg0, 6, b"AAADENG", b"AAAAAADENG", b"AAAAAAAAAAAAAAAAAAA", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/imagem_2024_10_11_185939069_b7f9559200.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AAADENG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AAADENG>>(v1);
    }

    // decompiled from Move bytecode v6
}

