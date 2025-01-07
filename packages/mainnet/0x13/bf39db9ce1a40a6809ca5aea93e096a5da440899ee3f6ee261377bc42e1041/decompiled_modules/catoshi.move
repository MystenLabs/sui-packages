module 0x13bf39db9ce1a40a6809ca5aea93e096a5da440899ee3f6ee261377bc42e1041::catoshi {
    struct CATOSHI has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATOSHI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATOSHI>(arg0, 6, b"CATOSHI", b"CATOSHI ERA CAT", b"CAToshi is a kitten from a long generation of cats that can be traced back to the Satoshi era. Theyve been the guardians of the blocks and the watch-cats that have kept miners and validators in check. CAToshi inherits the most attractive and valiant traits from its cat ancestors.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/f0f39520_5e98_4f6d_a24e_371b76287808_2e7403d3fa.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATOSHI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CATOSHI>>(v1);
    }

    // decompiled from Move bytecode v6
}

