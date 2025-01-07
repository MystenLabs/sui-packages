module 0xeb8df2d4c6ca2221f722193ed8b94b1549e0e7002dd2912f10331ff4068ec545::giko {
    struct GIKO has drop {
        dummy_field: bool,
    }

    fun init(arg0: GIKO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GIKO>(arg0, 6, b"GIKO", b"Giko", x"47696b6f2043617420282f47696b6f204e656b6f2920697320616e20415343494920617274206361742074686174206f726967696e617465642066726f6d207468650a4a6170616e65736520696d616765626f61726420326368616e6e656c2028326368616e29696e20313939382e0a0a417320746865206d6173636f74206f6620326368616e2c20697420686173206e6f74206f6e6c79206265636f6d6520616e2069636f6e20696e20746865204a6170616e6573650a6f6e6c696e652073756263756c74757265206275742068617320616c736f20696e666c75656e63656420676c6f62616c20696e7465726e65742063756c747572652e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/K7q_Zi_SK_1_400x400_a8e784372e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GIKO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GIKO>>(v1);
    }

    // decompiled from Move bytecode v6
}

