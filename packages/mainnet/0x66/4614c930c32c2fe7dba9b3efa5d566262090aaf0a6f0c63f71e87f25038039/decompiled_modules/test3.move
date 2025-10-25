module 0x664614c930c32c2fe7dba9b3efa5d566262090aaf0a6f0c63f71e87f25038039::test3 {
    struct TEST3 has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<TEST3>, arg1: 0x2::coin::Coin<TEST3>) {
        0x2::coin::burn<TEST3>(arg0, arg1);
    }

    fun init(arg0: TEST3, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TEST3>(arg0, 9, b"test3", b"TEST3", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"http://34.27.172.105/uploads/logo_1761402221384_e400d9e2.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TEST3>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TEST3>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<TEST3>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<TEST3>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

