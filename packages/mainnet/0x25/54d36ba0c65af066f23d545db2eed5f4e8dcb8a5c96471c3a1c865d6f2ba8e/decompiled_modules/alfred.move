module 0x2554d36ba0c65af066f23d545db2eed5f4e8dcb8a5c96471c3a1c865d6f2ba8e::alfred {
    struct ALFRED has drop {
        dummy_field: bool,
    }

    fun init(arg0: ALFRED, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ALFRED>(arg0, 6, b"Alfred", b"Alfred on SUI", b"OWLS HOOT TOGETHER", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/CSN_8_NS_8e_400x400_4b50f1c96a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ALFRED>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ALFRED>>(v1);
    }

    // decompiled from Move bytecode v6
}

