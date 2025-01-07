module 0x2acc502f3d9364415c915bdab4cd82858e927f7dffdff2ba859ad0979f88bcd5::eggdolf {
    struct EGGDOLF has drop {
        dummy_field: bool,
    }

    fun init(arg0: EGGDOLF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EGGDOLF>(arg0, 6, b"Eggdolf", b"Eggdolf H.", b"Funny cut like a him, calm this eggdolf", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000107135_2c69b28dba.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EGGDOLF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<EGGDOLF>>(v1);
    }

    // decompiled from Move bytecode v6
}

