module 0x8f2f76bfa81e19970e479367e00bff6039949ba62bd115ca82649130fa0f48f5::ffffff {
    struct FFFFFF has drop {
        dummy_field: bool,
    }

    fun init(arg0: FFFFFF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FFFFFF>(arg0, 9, b"FFFFFF", x"616464c491", b"Deployed via Multi-Chain Token Deployer", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"ipfs://QmXaiUoLn3SS1MxLDbFqJeuzF61kzRNCs7nhWHtXp1pYue")), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<FFFFFF>>(0x2::coin::mint<FFFFFF>(&mut v2, 10000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<FFFFFF>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FFFFFF>>(v1);
    }

    // decompiled from Move bytecode v7
}

