module 0x3827a5748265a9771d9bf824262409e0f452d62b6ecc41e7c3493f0e05156b49::ius {
    struct IUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: IUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IUS>(arg0, 6, b"Ius", b"iuS", b"Sui backwards", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731047939702.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<IUS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IUS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

