module 0x3ddca07eac7c38178bba8adfd7a71cd69e53d934a583a33f7791e2d273e51239::dam {
    struct DAM has drop {
        dummy_field: bool,
    }

    fun init(arg0: DAM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DAM>(arg0, 9, b"DAM", b"suibeaver", b"suibeaver is the protector of the sui ecosystem.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://images5440471.s3.amazonaws.com/suibever_coin.jpeg")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DAM>>(v1);
        0x2::coin::mint_and_transfer<DAM>(&mut v2, 10000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<DAM>>(v2);
    }

    // decompiled from Move bytecode v6
}

