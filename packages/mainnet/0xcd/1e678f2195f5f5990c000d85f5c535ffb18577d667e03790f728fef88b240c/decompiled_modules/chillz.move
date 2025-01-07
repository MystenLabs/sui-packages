module 0xcd1e678f2195f5f5990c000d85f5c535ffb18577d667e03790f728fef88b240c::chillz {
    struct CHILLZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHILLZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHILLZ>(arg0, 6, b"Chillz", b"Chillzard", b"Chill guy + Charizard = CHILLZARD on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000051214_533b45e773.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHILLZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHILLZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

