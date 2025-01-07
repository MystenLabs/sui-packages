module 0xa9231027a944aea06ecc98893bc561454b300372f5079969b2fafa5cf9a7e255::breog {
    struct BREOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: BREOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BREOG>(arg0, 6, b"BREOG", b"Brett mog", x"536f6d65206f6620746865206d6f737420696d706f7274616e7420746f6b656e730a746869732074696d65206465636964656420746f20617265616e676520610a6c6567656e6461727920636f6c6c61626f726174696f6e20746861742077696c6c2062650a72656d656d62657265642062792065766572796f6e6520466f72657665722c20426520610a5769746e65737320746f2074686973206576656e74", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730958508375.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BREOG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BREOG>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

