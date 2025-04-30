module 0x352605c040b0e36b739d257c21c44d9f844926160e83a31e38d2492d96548790::pepai {
    struct PEPAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEPAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEPAI>(arg0, 6, b"PEPAI", b"Pepai", b"The First Pepai Agent on Blockchain SUI.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/92_97406f95ec.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEPAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PEPAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

