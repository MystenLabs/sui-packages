module 0x117153df0042b9182ad0d4ebb558893d37907b2498f415ba9cb2d04a2b5524cc::taciturneyes {
    struct TACITURNEYES has drop {
        dummy_field: bool,
    }

    fun init(arg0: TACITURNEYES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TACITURNEYES>(arg0, 8, b"TACI", b"taciturneyes coin", b"this is a taciturneyes coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://avatars.githubusercontent.com/u/77370454?v=4")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TACITURNEYES>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TACITURNEYES>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint<T0>(arg0: &mut 0x2::coin::TreasuryCap<T0>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<T0>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

