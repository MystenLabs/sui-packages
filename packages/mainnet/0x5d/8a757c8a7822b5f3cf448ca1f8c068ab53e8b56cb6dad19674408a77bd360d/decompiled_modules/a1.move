module 0x5d8a757c8a7822b5f3cf448ca1f8c068ab53e8b56cb6dad19674408a77bd360d::a1 {
    struct A1 has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<A1>, arg1: 0x2::coin::Coin<A1>) {
        0x2::coin::burn<A1>(arg0, arg1);
    }

    fun init(arg0: A1, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<A1>(arg0, 9, b"a1", b"a1", b"dex", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cdn.jsdelivr.net/gh/c0deCn/wiki@master/logo.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<A1>>(v1);
        0x2::coin::mint_and_transfer<A1>(&mut v2, 210000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<A1>>(v2, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<A1>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<A1>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

