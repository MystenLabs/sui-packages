module 0xb7e03b75a274c8ec148dfe1b5b6ac266d52b2cf38d4093ff7204e1a68ea5a27e::aquafina {
    struct AQUAFINA has drop {
        dummy_field: bool,
    }

    fun init(arg0: AQUAFINA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AQUAFINA>(arg0, 6, b"AQUAFINA", b"Aquafina", b"Pure water, perfect taste", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1440_AQUAFINA_Square_Full_Bleed_01_645ef72357.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AQUAFINA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AQUAFINA>>(v1);
    }

    // decompiled from Move bytecode v6
}

