module 0xf804993aa34735c97eae454f89e2d810ce9ecfc62f36650aafe39bdceba48444::yakub {
    struct YAKUB has drop {
        dummy_field: bool,
    }

    fun init(arg0: YAKUB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YAKUB>(arg0, 6, b"YAKUB", b"Yakub: Creator of the White Race", b"Creator of the White Race, Father of Humanity, Master of Tricknology", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_2110_e8cb3e60ea.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YAKUB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<YAKUB>>(v1);
    }

    // decompiled from Move bytecode v6
}

