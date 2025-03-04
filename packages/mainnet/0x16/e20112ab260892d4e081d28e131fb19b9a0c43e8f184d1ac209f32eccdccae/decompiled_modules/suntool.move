module 0x16e20112ab260892d4e081d28e131fb19b9a0c43e8f184d1ac209f32eccdccae::suntool {
    struct SUNTOOL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUNTOOL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUNTOOL>(arg0, 9, b"SUNTOOL", b"SUNTOOL", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://arweave.net/ckIM5AQAi7TOqhXVrCL6D9SFHAl_HgOE2GOmq22hbIA")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUNTOOL>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUNTOOL>>(v2, @0xb0ec095b93b7c545dff8b3bc829ad9cce9348a7ca1cd478cec14baa1a90e2867);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUNTOOL>>(v1);
    }

    // decompiled from Move bytecode v6
}

