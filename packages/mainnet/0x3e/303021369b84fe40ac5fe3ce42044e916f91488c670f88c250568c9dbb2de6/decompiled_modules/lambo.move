module 0x3e303021369b84fe40ac5fe3ce42044e916f91488c670f88c250568c9dbb2de6::lambo {
    struct LAMBO has drop {
        dummy_field: bool,
    }

    fun init(arg0: LAMBO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LAMBO>(arg0, 6, b"LAMBO", b"Sui Lambo CLub", x"556e6c6f636b207468652045787472616f7264696e6172792c0a41636365737320746865204578636c75736976652e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/SL_TOKEN_ICON_80052b4f22.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LAMBO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LAMBO>>(v1);
    }

    // decompiled from Move bytecode v6
}

