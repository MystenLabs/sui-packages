module 0x8f5984f282071c53cbed21d8d07855e7604ec2a6128540faccf1072ed1b2faa7::gowoke {
    struct GOWOKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOWOKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOWOKE>(arg0, 6, b"GOWOKE", b"Woke Chain", b"Decentralized Virtue Signalling", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Ez_E6t_AFP_400x400_a7edb115bc.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOWOKE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GOWOKE>>(v1);
    }

    // decompiled from Move bytecode v6
}

