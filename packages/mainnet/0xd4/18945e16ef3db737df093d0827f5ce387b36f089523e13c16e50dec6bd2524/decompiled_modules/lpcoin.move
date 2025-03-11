module 0xd418945e16ef3db737df093d0827f5ce387b36f089523e13c16e50dec6bd2524::lpcoin {
    struct LPCOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: LPCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LPCOIN>(arg0, 9, b"DEEP-SUI Vault LPT", b"DEEP-SUI Haedal Vault LP Token", b"Haedal Vault LP Token, DEEP-SUI Pool", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://node1.irys.xyz/NVpcEHcDm71AOiNdu5BjfZ5RoXwROnKMUE3PEwDOKM4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LPCOIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LPCOIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

