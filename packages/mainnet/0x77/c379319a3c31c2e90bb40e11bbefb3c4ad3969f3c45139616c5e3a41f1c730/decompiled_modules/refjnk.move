module 0x77c379319a3c31c2e90bb40e11bbefb3c4ad3969f3c45139616c5e3a41f1c730::refjnk {
    struct REFJNK has drop {
        dummy_field: bool,
    }

    fun init(arg0: REFJNK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<REFJNK>(arg0, 6, b"refjnk", b"refjnk", b"qeraf", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<REFJNK>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<REFJNK>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<REFJNK>>(v1);
    }

    // decompiled from Move bytecode v6
}

