module 0x842748b6936b5664ce024a6620578929fc280ebec47371c23c44b48bf308a8e7::zina {
    struct ZINA has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZINA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZINA>(arg0, 6, b"ZINA", b"ZINA on SUI", b"Zina ,the baby rhino (meaning secret/beautiful in swahili)", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/TRDZPWZU_400x400_0f22ffff74.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZINA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ZINA>>(v1);
    }

    // decompiled from Move bytecode v6
}

