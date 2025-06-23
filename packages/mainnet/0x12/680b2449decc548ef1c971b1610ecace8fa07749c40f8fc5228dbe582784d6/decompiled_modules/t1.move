module 0x12680b2449decc548ef1c971b1610ecace8fa07749c40f8fc5228dbe582784d6::t1 {
    struct T1 has drop {
        dummy_field: bool,
    }

    fun init(arg0: T1, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<T1>(arg0, 6, b"T1", b"TEST 1", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://storage.slaunch.xyz/staging/tokens/b35c7f7c-83b9-4fe8-885f-a81815b7cf56.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<T1>(&mut v2, 100000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<T1>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<T1>>(v1);
    }

    // decompiled from Move bytecode v6
}

