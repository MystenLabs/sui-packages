module 0xfe7ed73c58b97d819647f0565fa909775453082a2329694b3489e99b0f5749b2::kimsui {
    struct KIMSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: KIMSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KIMSUI>(arg0, 6, b"KIMSUI", b"KIM JONG SUI", b"Kim Jong on SUI!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/kimsui_76e396cc32.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KIMSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KIMSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

