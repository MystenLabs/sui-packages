module 0xc89b1d71408d90f07fa0435a2267f80b6cc878fb2ee9e0ef3c7b5006be93477d::boys {
    struct BOYS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOYS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOYS>(arg0, 8, b"Boys", b"BOYS ON SUI", b"Boys Become Men", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://framerusercontent.com/images/0KKocValgAmB9XHzcFI6tALxGGQ.jpg")), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<BOYS>>(0x2::coin::mint<BOYS>(&mut v2, 3000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BOYS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOYS>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

