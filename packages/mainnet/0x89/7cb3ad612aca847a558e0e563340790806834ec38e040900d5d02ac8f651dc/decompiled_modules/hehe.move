module 0x897cb3ad612aca847a558e0e563340790806834ec38e040900d5d02ac8f651dc::hehe {
    struct HEHE has drop {
        dummy_field: bool,
    }

    fun init(arg0: HEHE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HEHE>(arg0, 6, b"HEHE", b"HEHECAT SUI", b"The cat that laughs! hehe", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/LOGO_2_d001982b54.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HEHE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HEHE>>(v1);
    }

    // decompiled from Move bytecode v6
}

