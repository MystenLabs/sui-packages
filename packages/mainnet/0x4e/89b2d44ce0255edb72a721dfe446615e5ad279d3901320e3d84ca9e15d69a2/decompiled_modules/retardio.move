module 0x4e89b2d44ce0255edb72a721dfe446615e5ad279d3901320e3d84ca9e15d69a2::retardio {
    struct RETARDIO has drop {
        dummy_field: bool,
    }

    fun init(arg0: RETARDIO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RETARDIO>(arg0, 6, b"Retardio", b"Retardiosui", b"Retardio in sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/a_ae_a_c_20241013013540_34110fdae4.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RETARDIO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RETARDIO>>(v1);
    }

    // decompiled from Move bytecode v6
}

