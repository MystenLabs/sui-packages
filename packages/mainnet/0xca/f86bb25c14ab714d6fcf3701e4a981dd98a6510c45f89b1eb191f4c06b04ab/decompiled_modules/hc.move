module 0xcaf86bb25c14ab714d6fcf3701e4a981dd98a6510c45f89b1eb191f4c06b04ab::hc {
    struct HC has drop {
        dummy_field: bool,
    }

    fun init(arg0: HC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HC>(arg0, 6, b"HC", b"HopCat", b"First cat on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/rt5_E9_V_p_400x400_4716872f5b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HC>>(v1);
    }

    // decompiled from Move bytecode v6
}

