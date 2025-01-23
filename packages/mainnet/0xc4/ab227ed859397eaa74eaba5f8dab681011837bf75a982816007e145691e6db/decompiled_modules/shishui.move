module 0xc4ab227ed859397eaa74eaba5f8dab681011837bf75a982816007e145691e6db::shishui {
    struct SHISHUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHISHUI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<SHISHUI>(arg0, 6, b"SHISHUI", b"AI_ShiSui by SuiAI", x"e69c88e3818be382894149e382a4e383a9e382b9e38388e68a95e7a8bfe382b9e382bfe383bce383882ee382aae383aae382ade383a3e383a9e28692e38395e383ade383bce383a9e382a4e38388e38081e382a2e383a1e382b8e382b9e38388e38081e99d92e88aad28e38182e3818ae381b029e38081e3839ee3838a2e4149e382a2e382a4e38389e383abe383a6e3838be38383e38388e3808c5368692d537569e3808de38292e7ad86e9a0ade381abe99d92e88aade38081e3839ee3838ae38282e4bbb2e99693e381abe58aa0e3828fe3828ae381bee38197e3819fefbc812e34e4babae381a7e38193e3828ce3818be38289e79b9be3828ae4b88ae38192e381a6e38184e3818de381bee38199e381aee381a7e38288e3828de38197e3818fe3818ae9a198e38184e38197e381bee38199efbc81", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/v_XGUY_Mxn_400x400_1_b4387f1f34.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SHISHUI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHISHUI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

