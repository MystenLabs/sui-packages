module 0x53e9e43a595c6710e36fc7e1a0d1509bdd46cdbfbff200c8010de4ffde0473a4::p01 {
    struct P01 has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<P01>, arg1: 0x2::coin::Coin<P01>) {
        0x2::coin::burn<P01>(arg0, arg1);
    }

    fun init(arg0: P01, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<P01>(arg0, 6, b"P01", b"P01", b"abc", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<P01>>(v1);
        let v3 = &mut v2;
        let v4 = 0x2::tx_context::sender(arg1);
        mint(v3, 1000000000000000, v4, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<P01>>(v2, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<P01>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<P01>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

