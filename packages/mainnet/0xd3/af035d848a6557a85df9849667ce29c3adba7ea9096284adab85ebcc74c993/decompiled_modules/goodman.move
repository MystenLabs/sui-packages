module 0xd3af035d848a6557a85df9849667ce29c3adba7ea9096284adab85ebcc74c993::goodman {
    struct GOODMAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOODMAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOODMAN>(arg0, 6, b"Goodman", b"Saul Goodman", b"You'd better buy Saul", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"http://movepump.xyz/uploads/ea4a00d1cac37cddb3104de8092927b1_9f3face7b7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOODMAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GOODMAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

