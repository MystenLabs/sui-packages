module 0x49e0983e42d45060b866a70eeac8d43cd0e1b18e497bf3c033ead24a5b765bd3::test1 {
    struct TEST1 has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<TEST1>, arg1: 0x2::coin::Coin<TEST1>) {
        0x2::coin::burn<TEST1>(arg0, arg1);
    }

    fun init(arg0: TEST1, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TEST1>(arg0, 9, b"test1", b"TEST", b"Hi there", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"http://localhost:3001/uploads/logo_1761383017415_2c32d8c6.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TEST1>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TEST1>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<TEST1>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<TEST1>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

