module 0x377023ea89ae85b75520da976e7e2f4754b44046823b8c8ab788ce663a11d92a::test2 {
    struct TEST2 has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<TEST2>, arg1: 0x2::coin::Coin<TEST2>) {
        0x2::coin::burn<TEST2>(arg0, arg1);
    }

    fun init(arg0: TEST2, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TEST2>(arg0, 9, b"test2", b"test2", b"sdfsdfsd", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TEST2>>(v1);
        0x2::coin::mint_and_transfer<TEST2>(&mut v2, 10000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TEST2>>(v2, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<TEST2>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<TEST2>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

