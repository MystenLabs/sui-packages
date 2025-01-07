module 0xa7320bd77fda4b3f24ea64786e9903b1d446392e84f86831f8203b0c5114242a::wav {
    struct WAV has drop {
        dummy_field: bool,
    }

    fun init(arg0: WAV, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WAV>(arg0, 6, b"WAV", b"Wave on Sui", x"576176652057616c6c65740a54656c656772616d2d62617365642065636f73797374656d20666f722067616d6520616e6420442d617070730a0a737461720a506f77657265642062792053756920426c6f636b636861696e0a0a737461720a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/7f643358_151c_4dd6_be36_ff57add2bac8_eef1defb7e.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WAV>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WAV>>(v1);
    }

    // decompiled from Move bytecode v6
}

