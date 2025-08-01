module 0x1e4e940b31faccd9c5d46299e2b680d101ca629c1b106ef76ef383f346fc927f::GTEST8 {
    struct GTEST8 has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<GTEST8>, arg1: 0x2::coin::Coin<GTEST8>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::coin::burn<GTEST8>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<GTEST8>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<GTEST8>>(0x2::coin::mint<GTEST8>(arg0, arg1, arg3), arg2);
    }

    public entry fun freeze_treasury_cap(arg0: 0x2::coin::TreasuryCap<GTEST8>) {
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<GTEST8>>(arg0);
    }

    fun init(arg0: GTEST8, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GTEST8>(arg0, 9, b"GTEST8", b"GradTest8", b"This is just a test", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://bscscan.com/token/images/busdt_32.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GTEST8>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GTEST8>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

