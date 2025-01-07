module 0xc44ed1cb97498a3472a659893e02c5579f51d1bcf46a800cffdc73a9b293e2ad::doggy_sui {
    struct DOGGY_SUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGGY_SUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGGY_SUI>(arg0, 9, b"DOGGY SUI", x"f09f90b6446f67677920537569", b"Official token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<DOGGY_SUI>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGGY_SUI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOGGY_SUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

