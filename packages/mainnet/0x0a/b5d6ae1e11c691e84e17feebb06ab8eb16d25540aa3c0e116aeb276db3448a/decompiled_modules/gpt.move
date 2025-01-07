module 0xab5d6ae1e11c691e84e17feebb06ab8eb16d25540aa3c0e116aeb276db3448a::gpt {
    struct GPT has drop {
        dummy_field: bool,
    }

    fun init(arg0: GPT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GPT>(arg0, 8, b"GPT", b"SuiGPTAI", b"GEM", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1654120529119571973/9p7rU6Yj_400x400.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<GPT>(&mut v2, 30000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GPT>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GPT>>(v1);
    }

    // decompiled from Move bytecode v6
}

