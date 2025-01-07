module 0x4c29fbb1998b1496688dd9d33150bdbf277aadd987ba1ba15500a1af51d95b40::shi {
    struct SHI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHI>(arg0, 6, b"SHI", b"SHIBOSHI", x"456e6a6f7920746865206a6f75726e657920616e64206c657420796f757220536869626f73686920677569646520746865207761792c20666f73746572696e67206c6f79616c747920616e6420747275737420617420657665727920737465702e0a0a0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_09_15_02_15_56_609a96076b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHI>>(v1);
    }

    // decompiled from Move bytecode v6
}

