module 0xdfac71053f11717cf85eabfc36238359706bc12f07f713cb381920546408292c::q {
    struct Q has drop {
        dummy_field: bool,
    }

    fun init(arg0: Q, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<Q>(arg0, 6, b"Q", b"QQ", b"QG", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/a_ae_a_c_20230513151406_7a7fe3e89e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<Q>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<Q>>(v1);
    }

    // decompiled from Move bytecode v6
}

