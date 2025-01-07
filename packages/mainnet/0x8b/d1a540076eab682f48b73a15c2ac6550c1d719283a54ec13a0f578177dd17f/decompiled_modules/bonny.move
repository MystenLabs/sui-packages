module 0x8bd1a540076eab682f48b73a15c2ac6550c1d719283a54ec13a0f578177dd17f::bonny {
    struct BONNY has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<BONNY>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<BONNY>>(0x2::coin::mint<BONNY>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: BONNY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BONNY>(arg0, 6, b"BONNY", b"BONNY", b"MOMO is a nice guy who loves to make others laugh, but has a soft spot and doesn't like being alone.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://ivory-large-echidna-233.mypinata.cloud/ipfs/QmRkvRPj7de22FXqLXYgYVZCEWyzSk5UwueTxgfh9Lxo2x"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BONNY>>(v1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BONNY>(&mut v2, 10000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BONNY>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

