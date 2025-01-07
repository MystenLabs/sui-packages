module 0x5911c3ddbf7602c55f67de75f9da758803a93951a46cfeb41f707da6ed8fc9a8::tesla {
    struct TESLA has drop {
        dummy_field: bool,
    }

    fun init(arg0: TESLA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TESLA>(arg0, 6, b"Tesla", b"Tesla tokens", b"10000 tesla tokens for one tesla car  ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/a_ae_a_c_20240426014853_06b8e66c2f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TESLA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TESLA>>(v1);
    }

    // decompiled from Move bytecode v6
}

