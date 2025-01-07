module 0x26fc078e273ff675d11e9f5400fb7462b88afb2aefc101d4c24012050c5d391b::test001 {
    struct Registry has key {
        id: 0x2::object::UID,
        metadata: 0x2::coin::CoinMetadata<TEST001>,
    }

    struct TEST001 has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<TEST001>, arg1: 0x2::coin::Coin<TEST001>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : u64 {
        assert!(0x2::balance::value<TEST001>(0x2::coin::balance<TEST001>(&arg1)) >= arg2, 0);
        0x2::coin::burn<TEST001>(arg0, arg1)
    }

    public entry fun mint_and_transfer(arg0: &mut 0x2::coin::TreasuryCap<TEST001>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<TEST001>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: TEST001, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TEST001>(arg0, 9, b"PRO", b"TEST001", b"TEST001 Coin for bet gaming protocol", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://bafybeiecppfzpgx7xosf7h4a2zistip2d4lawqkwsp2dtp3ucmjpmnb6tq.ipfs.nftstorage.link/"))), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TEST001>>(v1);
        0x2::coin::mint_and_transfer<TEST001>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TEST001>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

