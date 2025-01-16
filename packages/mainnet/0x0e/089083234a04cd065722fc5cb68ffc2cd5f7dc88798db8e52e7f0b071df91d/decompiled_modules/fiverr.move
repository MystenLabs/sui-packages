module 0xe089083234a04cd065722fc5cb68ffc2cd5f7dc88798db8e52e7f0b071df91d::fiverr {
    struct FIVERR has drop {
        dummy_field: bool,
    }

    fun init(arg0: FIVERR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FIVERR>(arg0, 6, b"Fiverr", b"fiverr", b"fiverrrr", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Fiverr_Logo_52ea248ad4.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FIVERR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FIVERR>>(v1);
    }

    // decompiled from Move bytecode v6
}

