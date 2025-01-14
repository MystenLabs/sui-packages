module 0x366b44101179f79605e0fa971aa6e15eb0e31683b138ce69f830bbc4b93a29a::libertai {
    struct LIBERTAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: LIBERTAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<LIBERTAI>(arg0, 6, b"LIBERTAI", b"LibertAi  by SuiAI", x"f09f95b6efb88f202d20436f6e666964656e7469616c20414920666f7220626c6f636b636861696e20617070732e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/W_Ti_S_JU_400x400_48b7d7656b_408278025a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<LIBERTAI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LIBERTAI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

