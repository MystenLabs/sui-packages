module 0x6c58280bf2fc24f1ff204201adab301ce0b42996f2e1cde7efd92f6e890790b5::zina {
    struct ZINA has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZINA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZINA>(arg0, 6, b"ZINA", b"ZINA - Baby rhino", b"Zina ,the baby rhino (meaning secret/beautiful in swahili)", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/TRDZPWZU_400x400_e57a1184c3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZINA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ZINA>>(v1);
    }

    // decompiled from Move bytecode v6
}

