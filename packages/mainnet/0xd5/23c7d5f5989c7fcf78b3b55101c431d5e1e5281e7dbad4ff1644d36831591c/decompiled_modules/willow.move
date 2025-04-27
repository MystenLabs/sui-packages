module 0xd523c7d5f5989c7fcf78b3b55101c431d5e1e5281e7dbad4ff1644d36831591c::willow {
    struct WILLOW has drop {
        dummy_field: bool,
    }

    fun init(arg0: WILLOW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WILLOW>(arg0, 6, b"WILLOW", b"WILL", b"WILLOW ON SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/willow_a1d08b0afb.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WILLOW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WILLOW>>(v1);
    }

    // decompiled from Move bytecode v6
}

