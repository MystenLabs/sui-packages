module 0xb27799473288e9c3aabca9b417d3d6e0dcc238ea5797bd990e669eea878f8e1a::fmo {
    struct FMO has drop {
        dummy_field: bool,
    }

    fun init(arg0: FMO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FMO>(arg0, 6, b"FMO", b"FOMO", b"FOMO ON SUI ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000065036_7d2a571564.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FMO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FMO>>(v1);
    }

    // decompiled from Move bytecode v6
}

