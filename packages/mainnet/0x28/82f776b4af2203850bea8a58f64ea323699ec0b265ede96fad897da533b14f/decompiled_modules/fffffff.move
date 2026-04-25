module 0x2882f776b4af2203850bea8a58f64ea323699ec0b265ede96fad897da533b14f::fffffff {
    struct FFFFFFF has drop {
        dummy_field: bool,
    }

    fun init(arg0: FFFFFFF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FFFFFFF>(arg0, 9, b"FFFFFFF", b"aaaaffff", b"Deployed via Multi-Chain Token Deployer", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"ipfs://QmXaiUoLn3SS1MxLDbFqJeuzF61kzRNCs7nhWHtXp1pYue")), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<FFFFFFF>>(0x2::coin::mint<FFFFFFF>(&mut v2, 100000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<FFFFFFF>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FFFFFFF>>(v1);
    }

    // decompiled from Move bytecode v7
}

