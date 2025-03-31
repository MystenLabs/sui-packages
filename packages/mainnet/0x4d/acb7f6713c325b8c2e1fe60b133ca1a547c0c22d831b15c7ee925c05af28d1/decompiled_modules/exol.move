module 0x4dacb7f6713c325b8c2e1fe60b133ca1a547c0c22d831b15c7ee925c05af28d1::exol {
    struct EXOL has drop {
        dummy_field: bool,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<EXOL>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<EXOL>>(0x2::coin::mint<EXOL>(arg0, arg2 * 1000000000, arg3), arg1);
    }

    fun init(arg0: EXOL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EXOL>(arg0, 9, b"EXOL", b"EXOL", b"EXOL is the hottest, newest mascot on Sui!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1905515960527704064/_lO-L_H3_400x400.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<EXOL>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<EXOL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EXOL>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

