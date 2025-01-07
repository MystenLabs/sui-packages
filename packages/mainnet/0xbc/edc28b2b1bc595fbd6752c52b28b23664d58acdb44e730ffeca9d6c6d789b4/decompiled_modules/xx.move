module 0xbcedc28b2b1bc595fbd6752c52b28b23664d58acdb44e730ffeca9d6c6d789b4::xx {
    struct XX has drop {
        dummy_field: bool,
    }

    fun init(arg0: XX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XX>(arg0, 9, b"XX", b"XXYXX", b"Love", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://images.theconversation.com/files/122137/original/image-20160511-18171-kulas4.jpg?ixlib=rb-1.1.0&q=45&auto=format&w=926&fit=clip")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<XX>(&mut v2, 100000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XX>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<XX>>(v1);
    }

    // decompiled from Move bytecode v6
}

