module 0x7a6ccfb8d6a56bb94cd9f129a5a23a0952bb83c7ee4f39b8ccbfb11c1069d510::kaio {
    struct KAIO has drop {
        dummy_field: bool,
    }

    fun init(arg0: KAIO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KAIO>(arg0, 6, b"KAIO", b"Kaio", b"Derived from \"Kai,\" meaning ocean, Kaio is an explorer of infinite digital depths, always bringing fresh waves of knowledge.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000000570_52a96c5ac5.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KAIO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KAIO>>(v1);
    }

    // decompiled from Move bytecode v6
}

