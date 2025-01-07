module 0xc44ec53beec75df271e1fdda02bc09bc3e874de6c6e2e6f515adb9f4cd8330ac::kevinsui {
    struct KEVINSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: KEVINSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KEVINSUI>(arg0, 6, b"KEVINSUI", b"KEVIN", x"68616c662068756d616e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/imagem_2024_10_14_182202899_b8cf54d721.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KEVINSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KEVINSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

