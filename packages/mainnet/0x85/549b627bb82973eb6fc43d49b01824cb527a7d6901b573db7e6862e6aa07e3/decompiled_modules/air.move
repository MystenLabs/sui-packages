module 0x85549b627bb82973eb6fc43d49b01824cb527a7d6901b573db7e6862e6aa07e3::air {
    struct AIR has drop {
        dummy_field: bool,
    }

    fun init(arg0: AIR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AIR>(arg0, 9, b"AIR", b"AIRDROP", b"Airdrop Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<AIR>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AIR>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AIR>>(v1);
    }

    // decompiled from Move bytecode v6
}

