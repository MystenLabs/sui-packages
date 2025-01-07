module 0x7b82a5f136308a2a249ca13ed512779a098ade6f07f03f9eff0bc8e69c3c686d::suiwu {
    struct SUIWU has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIWU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIWU>(arg0, 6, b"SUIWU", b"Sui-WuFang", b"Meet Sui one and only Shark, WuFang!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Untitled_1323463b96.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIWU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIWU>>(v1);
    }

    // decompiled from Move bytecode v6
}

