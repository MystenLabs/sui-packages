module 0xb7cf7d731de442d7d4211f5d2db551642d66bea512a10e6f97f6c7101e8066c2::soil {
    struct SOIL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOIL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SOIL>(arg0, 6, b"SOIL", b"suiSOIL", b"$SOIL is a natural resource composed of organic matter, minerals, gases, liquids, and organisms that together support life", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/SOIL_f2c54a0b8b.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOIL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SOIL>>(v1);
    }

    // decompiled from Move bytecode v6
}

