module 0x458d76241e4b9bae67e0f6a2407c111beef0e8832ab15cdf75da1c1875ef850::wukong {
    struct WUKONG has drop {
        dummy_field: bool,
    }

    fun init(arg0: WUKONG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WUKONG>(arg0, 6, b"Wukong", b"WUKONG", b"WUKONG - king", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/wucong_bf234dd8ab.JPG")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WUKONG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WUKONG>>(v1);
    }

    // decompiled from Move bytecode v6
}

