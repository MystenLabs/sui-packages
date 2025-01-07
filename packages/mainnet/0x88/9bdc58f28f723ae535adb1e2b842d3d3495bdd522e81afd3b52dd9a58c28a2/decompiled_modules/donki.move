module 0x889bdc58f28f723ae535adb1e2b842d3d3495bdd522e81afd3b52dd9a58c28a2::donki {
    struct DONKI has drop {
        dummy_field: bool,
    }

    fun init(arg0: DONKI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DONKI>(arg0, 6, b"DONKI", b"Dave The Donki", x"4461766520697320736f20736d6f6c2068652066697473206f6e6c79206f6e2075722066696e676572746970732c2068652069732074686520666c6f6f666965737420646f6e6b692e0a48652077616e74656420746f2062652070726573656e74206f6e204d6f766570756d702c2077686f20636f756c6420736179206e6f20746f2068696d3f", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Log_A_05471876ec.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DONKI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DONKI>>(v1);
    }

    // decompiled from Move bytecode v6
}

