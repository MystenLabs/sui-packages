module 0x4f009ee621d52fa89cdea10e10924b95f6925754ac1ca5671e4c730debdcaf0d::suai {
    struct SUAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUAI>(arg0, 6, b"SUAI", b"SUI AI", x"4c61756e636820616e6420436f2d437265617465204f6e636861696e204149204167656e7473200a405375694e6574776f726b", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20250107_033302_826_c850bf3f79.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

