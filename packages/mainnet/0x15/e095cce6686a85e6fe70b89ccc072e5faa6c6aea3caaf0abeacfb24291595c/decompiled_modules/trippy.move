module 0x15e095cce6686a85e6fe70b89ccc072e5faa6c6aea3caaf0abeacfb24291595c::trippy {
    struct TRIPPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRIPPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRIPPY>(arg0, 6, b"Trippy", b"Trippy Fish", b"Trippy Fish is a Trippy Fish", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/trippy_fish_110ab51d55.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRIPPY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRIPPY>>(v1);
    }

    // decompiled from Move bytecode v6
}

