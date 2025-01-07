module 0xb32a68fcd780cf13e3ce6f06f5fa4a813924013029dccbe51ed3406c4baa1a8a::fac {
    struct FAC has drop {
        dummy_field: bool,
    }

    fun init(arg0: FAC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FAC>(arg0, 6, b"FAC", b"FlyingAvoCat", b"No Twitter no socials let it fly then watch it die", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/21_D27_C6_C_eab82f10d0.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FAC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FAC>>(v1);
    }

    // decompiled from Move bytecode v6
}

