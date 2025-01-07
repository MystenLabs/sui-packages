module 0xf0bb45ce186a1a83892b05f9fdedc9b1882d0697f3434a4b7f02ffb7e878219::dui {
    struct DUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: DUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DUI>(arg0, 6, b"DUI", b"DANK", b"DANK ON SUI ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_9084_c55c272cce.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

