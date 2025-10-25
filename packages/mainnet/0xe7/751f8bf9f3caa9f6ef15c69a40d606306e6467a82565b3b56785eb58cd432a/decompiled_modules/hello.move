module 0xe7751f8bf9f3caa9f6ef15c69a40d606306e6467a82565b3b56785eb58cd432a::hello {
    struct HELLO has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<HELLO>, arg1: 0x2::coin::Coin<HELLO>) {
        0x2::coin::burn<HELLO>(arg0, arg1);
    }

    fun init(arg0: HELLO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HELLO>(arg0, 6, b"HELLO", b"hello", b"Go and fuck the world!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"http://localhost:3001/uploads/logo_1761378212140_88f44c43.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HELLO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HELLO>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<HELLO>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<HELLO>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

