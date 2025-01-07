module 0x4421fc3db7f37a5ca20804377bf76ef94a7dbabc0e6786f7cd6e1ba99c1393cb::suipepe {
    struct SUIPEPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIPEPE>(arg0, 6, b"SUIPEPE", b"SUICIDE PEPE", b"first suicide pepe on sui chain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/images_2_d50a028cd0.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPEPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPEPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

