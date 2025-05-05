module 0x95385c1418213a0fb2ee9e89dc9cb88e0c0bfd8d2dc215a0cd1fe23bec84ca14::tueyii22 {
    struct TUEYII22 has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<TUEYII22>, arg1: 0x2::coin::Coin<TUEYII22>) {
        0x2::coin::burn<TUEYII22>(arg0, arg1);
    }

    fun init(arg0: TUEYII22, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TUEYII22>(arg0, 2, b"TUEYII22", b"hahatest12", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TUEYII22>>(v1);
        let v3 = &mut v2;
        let v4 = 0x2::tx_context::sender(arg1);
        mint(v3, 100000000, v4, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TUEYII22>>(v2, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<TUEYII22>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<TUEYII22>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

