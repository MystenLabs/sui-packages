module 0xc1b2294c17114a9a9d839e0af032b2e6cd6394ffe087b7fe86b92fc81e49c114::sui_dog {
    struct SUI_DOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUI_DOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUI_DOG>(arg0, 9, b"SUI DOG", x"f09f90b653756920446f67", b"Official token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUI_DOG>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUI_DOG>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUI_DOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

