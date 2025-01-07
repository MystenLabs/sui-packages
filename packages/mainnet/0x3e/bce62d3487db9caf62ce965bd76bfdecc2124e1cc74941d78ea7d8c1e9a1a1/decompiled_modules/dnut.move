module 0x3ebce62d3487db9caf62ce965bd76bfdecc2124e1cc74941d78ea7d8c1e9a1a1::dnut {
    struct DNUT has drop {
        dummy_field: bool,
    }

    fun init(arg0: DNUT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DNUT>(arg0, 6, b"DNUT", b"DOGNUT ON SUI", b"Dognut carries on Peanut the Squirrel's mission, fighting for freedom and change. Their spirit lives on!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/dnut_97fc438e2c.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DNUT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DNUT>>(v1);
    }

    // decompiled from Move bytecode v6
}

