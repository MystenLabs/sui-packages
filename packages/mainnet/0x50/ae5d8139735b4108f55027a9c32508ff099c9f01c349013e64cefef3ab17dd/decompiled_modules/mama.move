module 0x50ae5d8139735b4108f55027a9c32508ff099c9f01c349013e64cefef3ab17dd::mama {
    struct MAMA has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<MAMA>, arg1: 0x2::coin::Coin<MAMA>) {
        0x2::coin::burn<MAMA>(arg0, arg1);
    }

    fun init(arg0: MAMA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAMA>(arg0, 9, b"MAMA", b"MANNA MAKER COGNITIVE OS", x"596f75277665206265656e2061776172646564206f757220417070726563696174696f6e20546f6b656e7320666f722068656c70696e672067726f7720666f6c6c6f77657273206f6e2068747470733a2f2f782e636f6d2f70617374736d6172746c696e6b2e205765207472756c79206170707265636961746520796f757220737570706f7274e2809473616c75746520746f20796f7572206f7267616e696320687573746c652120536861726520746865206d616e6e6120616e64206c6574277320616d706c69667920746f6765746865722e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://orange-useful-bison-423.mypinata.cloud/ipfs/bafybeieodvkoka73tqzrkeyuf65fwj5yvl6e662w6ym7rfzzx7kmd2djk4")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MAMA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<MAMA>>(0x2::coin::mint<MAMA>(&mut v2, 10000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAMA>>(v2, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint_more(arg0: &mut 0x2::coin::TreasuryCap<MAMA>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 > 0, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<MAMA>>(0x2::coin::mint<MAMA>(arg0, arg1, arg2), 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

