module 0xbf43216ebd36e4a430f6472222abb157ca744f4c4a8016a64465bedd2697e2a6::suipson {
    struct SUIPSON has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPSON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIPSON>(arg0, 6, b"SUIPSON", b"Suipson", b"Meet Suipson, the mascott based on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/profile_picture_1c5ae60f4e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPSON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPSON>>(v1);
    }

    // decompiled from Move bytecode v6
}

