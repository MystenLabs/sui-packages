module 0xfc8abc0ba8c13316f5c21dae30f89819d5fcf3a95ef80e45f5fe7213ebdc6a84::lfg {
    struct LFG has drop {
        dummy_field: bool,
    }

    fun init(arg0: LFG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LFG>(arg0, 6, b"LFG", b"Gold Funky Llama", b"LFG stands for \"Let's F-king Go! Or maybe its Llama Feeling Good? Nope, its Gold Funky Llama (with a twist)", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/lfg_1_1_2_819be7d735.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LFG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LFG>>(v1);
    }

    // decompiled from Move bytecode v6
}

