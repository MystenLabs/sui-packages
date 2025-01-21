module 0xd400f7de570f4876048267592e99d9c98f51e7ac37e4be191d1c13a5e23abb7f::dsgdaf {
    struct DSGDAF has drop {
        dummy_field: bool,
    }

    fun init(arg0: DSGDAF, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<DSGDAF>(arg0, 6, b"DSGDAF", b"fsdgh by SuiAI", b"asfdgd", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/of_Fa_Nilk_400x400_1c0961f166.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DSGDAF>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DSGDAF>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

