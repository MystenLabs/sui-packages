module 0xba5f53dff20a2cfd24acb7c4eac412f22074bb126911eae69c8eae0de787e3dd::kai {
    struct KAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: KAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<KAI>(arg0, 6, b"KAI", b"PIKAISUI by SuiAI", x"4b4149205375692c20414920746861742067726f7773207769746820697473206d61726b6574206361702c20756e6c65617368696e6720756e73746f707061626c6520706f776572206f6e207468652053554920626c6f636b636861696e20e29aa1efb88ff09fa4962e204461726520746f20636174636820746865206c6567656e643f20", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/Mekq3_WD_0_400x400_d6cbeb1f82.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<KAI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KAI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

