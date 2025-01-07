module 0x6f643c535be6a1435160af139a119c8887993b306d7a1647319ecc907a86ae8d::coucou {
    struct COUCOU has drop {
        dummy_field: bool,
    }

    fun init(arg0: COUCOU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COUCOU>(arg0, 6, b"Coucou", b"Laxozer", b"donneargent", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/438078007_10228027948458262_643429033324803823_n_41ba838639.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COUCOU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<COUCOU>>(v1);
    }

    // decompiled from Move bytecode v6
}

