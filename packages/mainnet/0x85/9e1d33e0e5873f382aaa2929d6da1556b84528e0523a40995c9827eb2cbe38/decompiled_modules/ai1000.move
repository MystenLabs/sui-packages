module 0x859e1d33e0e5873f382aaa2929d6da1556b84528e0523a40995c9827eb2cbe38::ai1000 {
    struct AI1000 has drop {
        dummy_field: bool,
    }

    fun init(arg0: AI1000, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AI1000>(arg0, 6, b"AI1000", b"AI1000 DAO", b"AI1000 is the first ultimate AI Agent built from WhaleFramework. An automated fund utilizes real-time data and on-chain analysis to optimize profits for users. More than a tool, AI 1000 marks a new era in AI and blockchain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://public.daossui.io/dao-sui/assets/AI1000-token.jpg")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AI1000>>(v1);
        0x2::coin::mint_and_transfer<AI1000>(&mut v2, 1100000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AI1000>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

