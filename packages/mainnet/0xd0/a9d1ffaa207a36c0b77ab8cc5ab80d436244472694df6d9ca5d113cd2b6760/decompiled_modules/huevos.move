module 0xd0a9d1ffaa207a36c0b77ab8cc5ab80d436244472694df6d9ca5d113cd2b6760::huevos {
    struct HUEVOS has drop {
        dummy_field: bool,
    }

    fun init(arg0: HUEVOS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HUEVOS>(arg0, 6, b"HUEVOS", b"FIRST HUEVOS ON SUI", b"I am the first Bitcoin mascot on Sui: https://www.huevosonsui.xyz", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/BTC_3f784e736c.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HUEVOS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HUEVOS>>(v1);
    }

    // decompiled from Move bytecode v6
}

