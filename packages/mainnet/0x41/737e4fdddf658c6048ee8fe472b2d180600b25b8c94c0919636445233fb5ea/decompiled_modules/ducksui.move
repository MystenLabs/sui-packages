module 0x41737e4fdddf658c6048ee8fe472b2d180600b25b8c94c0919636445233fb5ea::ducksui {
    struct DUCKSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: DUCKSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DUCKSUI>(arg0, 6, b"DUCKSUI", b"PIXEL DUCK", b"QUACK", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/imagem_2024_10_12_030545525_e5e5006018.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DUCKSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DUCKSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

