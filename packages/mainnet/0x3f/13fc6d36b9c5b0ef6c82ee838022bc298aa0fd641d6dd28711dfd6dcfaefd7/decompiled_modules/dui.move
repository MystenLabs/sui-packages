module 0x3f13fc6d36b9c5b0ef6c82ee838022bc298aa0fd641d6dd28711dfd6dcfaefd7::dui {
    struct DUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: DUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DUI>(arg0, 6, b"DUI", b"DANK", b"DANK ON SUI 170 Member now Lets Hit 500 members", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_9084_730af13817.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

