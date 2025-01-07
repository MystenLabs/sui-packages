module 0x2de96611d2a3c73a08cc792f6d6bdcff8d2fe924a6a8f4d47816b259e96cf7e0::ABC {
    struct ABC has drop {
        dummy_field: bool,
    }

    fun init(arg0: ABC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ABC>(arg0, 6, b"ABC", b"ABC Token", b"ABC TOKEN IS REALYL COOOL", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d391b93f5f62d9c15f67142e43841acc.ipfscdn.io/ipfs/QmbjzZnfgc3eG4Qbjze94G7TNXnyGV61rAiRbciVdKC3RP")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ABC>>(v1);
        0x2::coin::mint_and_transfer<ABC>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ABC>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

