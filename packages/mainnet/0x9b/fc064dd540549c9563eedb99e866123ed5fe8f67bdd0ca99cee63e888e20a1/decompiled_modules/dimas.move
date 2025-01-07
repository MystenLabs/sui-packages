module 0x9bfc064dd540549c9563eedb99e866123ed5fe8f67bdd0ca99cee63e888e20a1::dimas {
    struct DIMAS has drop {
        dummy_field: bool,
    }

    fun init(arg0: DIMAS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DIMAS>(arg0, 6, b"DIMAS", b"Dimas make money", b"a man who claims to have the ability to double money", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/G_Zfd2_las_A_Als_a_511aff0ca9.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DIMAS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DIMAS>>(v1);
    }

    // decompiled from Move bytecode v6
}

