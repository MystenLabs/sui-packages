module 0xf1414db578d37367feba10827598e30189f34d85c4331b200ed300dd449f0d07::goodylili {
    struct GOODYLILI has drop {
        dummy_field: bool,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<GOODYLILI>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<GOODYLILI>>(0x2::coin::mint<GOODYLILI>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: GOODYLILI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOODYLILI>(arg0, 8, b"GOODYLILI", b"GOODYLILI ON SUI", b"Goodylili Taught Sui. Here's proof", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://framerusercontent.com/images/0KKocValgAmB9XHzcFI6tALxGGQ.jpg")), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<GOODYLILI>>(0x2::coin::mint<GOODYLILI>(&mut v2, 30000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GOODYLILI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOODYLILI>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

