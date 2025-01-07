module 0x6e3de1a65025c7013473045b785b079823d4523f04f6564bb0fb48d16f3812f8::hippocoin {
    struct HIPPOCOIN has drop {
        dummy_field: bool,
    }

    public fun add_addr_from_deny_list(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<HIPPOCOIN>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<HIPPOCOIN>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: HIPPOCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<HIPPOCOIN>(arg0, 6, b"HIPPO2.0", b"HIPPO2.0", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d391b93f5f62d9c15f67142e43841acc.ipfscdn.io/ipfs/QmWeVfSw6yrezGS8PNsk2ipmDRR31FTBdffVhBULLQ2iQ2")), false, arg1);
        let v3 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HIPPOCOIN>>(v2);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<HIPPOCOIN>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<HIPPOCOIN>>(0x2::coin::mint<HIPPOCOIN>(&mut v3, 210000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<HIPPOCOIN>>(v3);
    }

    public fun remove_addr_from_deny_list(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<HIPPOCOIN>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<HIPPOCOIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

