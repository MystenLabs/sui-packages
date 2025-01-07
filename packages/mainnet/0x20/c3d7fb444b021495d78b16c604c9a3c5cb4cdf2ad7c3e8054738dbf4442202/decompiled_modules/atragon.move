module 0x20c3d7fb444b021495d78b16c604c9a3c5cb4cdf2ad7c3e8054738dbf4442202::atragon {
    struct ATRAGON has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<ATRAGON>, arg1: 0x2::coin::Coin<ATRAGON>) {
        0x2::coin::burn<ATRAGON>(arg0, arg1);
    }

    fun init(arg0: ATRAGON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ATRAGON>(arg0, 9, b"atragon", b"atragon", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ATRAGON>>(v1);
        0x2::coin::mint_and_transfer<ATRAGON>(&mut v2, 210000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ATRAGON>>(v2, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<ATRAGON>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<ATRAGON>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

