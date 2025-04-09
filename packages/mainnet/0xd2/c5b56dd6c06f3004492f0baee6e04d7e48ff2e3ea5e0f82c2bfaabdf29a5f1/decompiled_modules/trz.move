module 0xd2c5b56dd6c06f3004492f0baee6e04d7e48ff2e3ea5e0f82c2bfaabdf29a5f1::trz {
    struct TRZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRZ>(arg0, 6, b"Trz", b"Trmpzilla", b"Strong", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1001244673_1417d3aa7a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

