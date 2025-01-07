module 0xe2c96d0715a4e9c4e0e2dc9b4bd2ebadff2536a3c9b51d9fbaa0c2aeb883d92d::haya {
    struct HAYA has drop {
        dummy_field: bool,
    }

    fun init(arg0: HAYA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HAYA>(arg0, 6, b"HAYA", b"HEY ARNOLD", b"HEYNARNOLD", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/0wcypiew_2c1a091385.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HAYA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HAYA>>(v1);
    }

    // decompiled from Move bytecode v6
}

