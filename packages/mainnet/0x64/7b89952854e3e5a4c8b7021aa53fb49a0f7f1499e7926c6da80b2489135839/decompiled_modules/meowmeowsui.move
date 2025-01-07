module 0x647b89952854e3e5a4c8b7021aa53fb49a0f7f1499e7926c6da80b2489135839::meowmeowsui {
    struct MEOWMEOWSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEOWMEOWSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEOWMEOWSUI>(arg0, 6, b"MEOWMEOWSUI", b"FAMOUS CAT TIKTOK", b" meow meow meow meooow ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/imagem_2024_10_15_000853825_602a4122e9.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEOWMEOWSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MEOWMEOWSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

