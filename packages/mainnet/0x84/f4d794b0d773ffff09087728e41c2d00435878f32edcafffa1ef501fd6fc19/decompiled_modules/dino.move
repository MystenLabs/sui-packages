module 0x84f4d794b0d773ffff09087728e41c2d00435878f32edcafffa1ef501fd6fc19::dino {
    struct DINO has drop {
        dummy_field: bool,
    }

    fun init(arg0: DINO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DINO>(arg0, 6, b"DINO", b"Dino", b"a cute cartoon dinosaur", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/cfb7d50e711b49aba98ac44383073a_a50f30177f.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DINO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DINO>>(v1);
    }

    // decompiled from Move bytecode v6
}

