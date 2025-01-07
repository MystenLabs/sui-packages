module 0xfa944ff2638bebbbf65d14aed77f2a24f0e81933da87106ac6699f1f09609122::SQUIDTEST {
    struct SQUIDTEST has drop {
        dummy_field: bool,
    }

    public entry fun transfer(arg0: 0x2::coin::Coin<SQUIDTEST>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::Coin<SQUIDTEST>>(arg0, arg1);
    }

    fun init(arg0: SQUIDTEST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SQUIDTEST>(arg0, 9, b"SQD", b"Quid test", b"The governance token of Interest Protocol", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://interestprotocol.infura-ipfs.io/ipfs/QmXCQHziDxHP3b4tvoYLUs5h6RyaX1z5zNP9zdYNRjjxsP")), arg1);
        let v2 = v0;
        let v3 = 0x2::tx_context::sender(arg1);
        0x2::coin::mint_and_transfer<SQUIDTEST>(&mut v2, 100000000000000000, v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SQUIDTEST>>(v2, v3);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SQUIDTEST>>(v1);
    }

    entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SQUIDTEST>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SQUIDTEST>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

