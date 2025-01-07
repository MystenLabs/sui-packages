module 0x18ce683fc603f99bf967ea776babaf3b3f2998ca215f94fc19971267d06d659d::dbs {
    struct DBS has drop {
        dummy_field: bool,
    }

    fun init(arg0: DBS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DBS>(arg0, 6, b"DBS", b"DragonBallz Sui", b"DragonBallz on the Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/c78c7e0b_5f7f_4ef4_b699_2e451b8e304a_18092e8613.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DBS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DBS>>(v1);
    }

    // decompiled from Move bytecode v6
}

