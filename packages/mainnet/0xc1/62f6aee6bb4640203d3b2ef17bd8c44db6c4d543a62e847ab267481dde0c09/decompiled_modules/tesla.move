module 0xc162f6aee6bb4640203d3b2ef17bd8c44db6c4d543a62e847ab267481dde0c09::tesla {
    struct TESLA has drop {
        dummy_field: bool,
    }

    fun init(arg0: TESLA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TESLA>(arg0, 6, b"TESLA", b"TESLACONOMICS", b"Teslaconomics Principal", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Wv_S_v_M_Ht_400x400_1fc55a168d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TESLA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TESLA>>(v1);
    }

    // decompiled from Move bytecode v6
}

