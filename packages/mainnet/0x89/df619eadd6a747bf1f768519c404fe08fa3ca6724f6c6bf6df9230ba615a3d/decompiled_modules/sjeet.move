module 0x89df619eadd6a747bf1f768519c404fe08fa3ca6724f6c6bf6df9230ba615a3d::sjeet {
    struct SJEET has drop {
        dummy_field: bool,
    }

    fun init(arg0: SJEET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SJEET>(arg0, 6, b"SJEET", b"SUIJEET", b"Jeets fish on all SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_14_01_38_03_6ad4a637b6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SJEET>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SJEET>>(v1);
    }

    // decompiled from Move bytecode v6
}

