module 0x77102cb83838cd7443fdc113251351d9b2bd4351c24b8e7c0e091ae7a18471a7::iusday {
    struct IUSDAY has drop {
        dummy_field: bool,
    }

    fun init(arg0: IUSDAY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IUSDAY>(arg0, 6, b"IUSDAY", b"IUS DAY", b"Memecoin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000009937_da3d5e0cf8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IUSDAY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<IUSDAY>>(v1);
    }

    // decompiled from Move bytecode v6
}

