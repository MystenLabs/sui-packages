module 0x484bf8199c2508b1adf373d52e3eb7a1a1a5c98186e74ac293ffb44bb8b5e6f::shunter {
    struct SHUNTER has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHUNTER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHUNTER>(arg0, 6, b"SHUNTER", b"SUI HUNTER", b"Your treasure-hunting platform for sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/0l_Ko_R3f2_400x400_166eecea4f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHUNTER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHUNTER>>(v1);
    }

    // decompiled from Move bytecode v6
}

