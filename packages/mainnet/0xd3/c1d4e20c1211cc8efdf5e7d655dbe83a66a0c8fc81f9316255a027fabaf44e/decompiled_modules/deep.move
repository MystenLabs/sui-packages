module 0xd3c1d4e20c1211cc8efdf5e7d655dbe83a66a0c8fc81f9316255a027fabaf44e::deep {
    struct DEEP has drop {
        dummy_field: bool,
    }

    fun init(arg0: DEEP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DEEP>(arg0, 9, b"DEEP", b"DeepBook Token", b"The DEEP token secures the DeepBook protocol, the premier wholesale liquidity venue for on-chain trading.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://images.deepbook.tech/icon.svg")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DEEP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<DEEP>>(0x2::coin::mint<DEEP>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<DEEP>>(v2);
    }

    // decompiled from Move bytecode v6
}

