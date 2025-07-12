module 0xca9f4750790d39442e69c64b5761ad8e5b815790739eb74b06d463da78a896f6::skebob {
    struct SKEBOB has drop {
        dummy_field: bool,
    }

    fun init(arg0: SKEBOB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SKEBOB>(arg0, 6, b"SKEBOB", b"Bird rot", b"Viral Russian bird", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/skebob_0ac077c344.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SKEBOB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SKEBOB>>(v1);
    }

    // decompiled from Move bytecode v6
}

