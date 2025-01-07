module 0x51c36659054e3517b72303aa57ab1ffe0e3d106fd8748207f82eed8c14f56208::robovan {
    struct ROBOVAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: ROBOVAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ROBOVAN>(arg0, 6, b"Robovan", b"Robovan SUI", x"456c6563747269632076656869636c65732c206769616e7420626174746572696573202620736f6c61722c204149202620726f626f746963730a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Wechat_IMG_456_24d70974bc.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ROBOVAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ROBOVAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

