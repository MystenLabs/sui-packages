module 0xea336e0805f6db5b83c038bf6d3ebdc290a78e1b8e6c09fd47f40a3225f0696b::fmo {
    struct FMO has drop {
        dummy_field: bool,
    }

    fun init(arg0: FMO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FMO>(arg0, 6, b"FMO", b"F0M0", b"FOMO ON SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000065036_1c49c64bbb.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FMO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FMO>>(v1);
    }

    // decompiled from Move bytecode v6
}

