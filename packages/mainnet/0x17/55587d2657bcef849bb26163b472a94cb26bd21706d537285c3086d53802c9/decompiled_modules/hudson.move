module 0x1755587d2657bcef849bb26163b472a94cb26bd21706d537285c3086d53802c9::hudson {
    struct HUDSON has drop {
        dummy_field: bool,
    }

    fun init(arg0: HUDSON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HUDSON>(arg0, 6, b"HUDSON", b"Hudson on SUI", x"487564736f6e2061696e277420796f757220636f6d6d6f6e207075700a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/4_Izjhmf_400x400_2d58f84ec5.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HUDSON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HUDSON>>(v1);
    }

    // decompiled from Move bytecode v6
}

