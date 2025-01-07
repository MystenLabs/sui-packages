module 0xc880bdbf734a917aba75817f9598084967b785e6a9723c51e302d133d29a8659::endy {
    struct ENDY has drop {
        dummy_field: bool,
    }

    fun init(arg0: ENDY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ENDY>(arg0, 6, b"ENDY", b"ENDY SUI", x"24454e4459206f6e205375690a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ovmon_1065b54376.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ENDY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ENDY>>(v1);
    }

    // decompiled from Move bytecode v6
}

