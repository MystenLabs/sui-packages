module 0x92f6666fd26b1bc0518504020140835dfe8fb1d55ae97c17c099cffcbfdfff15::bunnysui {
    struct BUNNYSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUNNYSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUNNYSUI>(arg0, 6, b"BUNNYSUI", b"BUNNY SUI", x"456d627261636520746865205768696d736963616c20576f726c64206f662042554e4e590a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Imagem_do_Whats_App_de_2024_05_05_A_s_11_25_15_0e50e254_54caccae36.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUNNYSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BUNNYSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

