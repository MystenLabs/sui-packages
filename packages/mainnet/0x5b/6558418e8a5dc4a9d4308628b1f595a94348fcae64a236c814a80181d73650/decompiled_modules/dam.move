module 0x5b6558418e8a5dc4a9d4308628b1f595a94348fcae64a236c814a80181d73650::dam {
    struct DAM has drop {
        dummy_field: bool,
    }

    fun init(arg0: DAM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DAM>(arg0, 9, b"DAM", b"suibeaver", b"suibeaver is the protector of the sui ecosystem. Retar Dio", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://images5440471.s3.us-east-1.amazonaws.com/suibeaver.jpeg")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DAM>>(v1);
        let v3 = 0x2::tx_context::sender(arg1);
        0x2::coin::mint_and_transfer<DAM>(&mut v2, 10000000000000000000, v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DAM>>(v2, v3);
    }

    // decompiled from Move bytecode v6
}

