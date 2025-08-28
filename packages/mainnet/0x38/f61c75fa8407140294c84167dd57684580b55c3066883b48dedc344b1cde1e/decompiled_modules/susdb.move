module 0x38f61c75fa8407140294c84167dd57684580b55c3066883b48dedc344b1cde1e::susdb {
    struct SUSDB has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUSDB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUSDB>(arg0, 6, b"sUSDB", b"Staked Bucket USD", x"207355534442206973204275636b65742050726f746f636f6ce2809973207969656c642d62656172696e67207265636569707420746f6b656e20666f722055534442207374616b656420696e746f20746865207374616b696e6720706f6f6c2e204974732076616c75652061707072656369617465732076696120616e20696e6372656173696e672065786368616e676520726174652064726976656e20627920746865204261736520536176696e67732052617465202842535229", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.bucketprotocol.io/icons/sUSDB.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUSDB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUSDB>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

