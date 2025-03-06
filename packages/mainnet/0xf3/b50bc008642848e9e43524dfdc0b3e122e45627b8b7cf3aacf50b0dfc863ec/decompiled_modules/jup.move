module 0xf3b50bc008642848e9e43524dfdc0b3e122e45627b8b7cf3aacf50b0dfc863ec::jup {
    struct JUP has drop {
        dummy_field: bool,
    }

    fun init(arg0: JUP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JUP>(arg0, 9, b"JUP", b"JUP", b"JUPJUPJUP", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://bulltrend-images.s3.amazonaws.com/images/1d9fe9b39e62cd3fb9a9d47ebe68c2079a5cdc202dee9ab341dda9f9694ec178")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<JUP>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JUP>>(v2, @0xf55443938e7ecdc1181f60d605c77013d29a4fcf1362658e6fda627cd25cfc2c);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JUP>>(v1);
    }

    // decompiled from Move bytecode v6
}

