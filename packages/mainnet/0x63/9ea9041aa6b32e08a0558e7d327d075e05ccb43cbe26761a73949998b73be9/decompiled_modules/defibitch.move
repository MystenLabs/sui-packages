module 0x639ea9041aa6b32e08a0558e7d327d075e05ccb43cbe26761a73949998b73be9::defibitch {
    struct DEFIBITCH has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<DEFIBITCH>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<DEFIBITCH>>(0x2::coin::mint<DEFIBITCH>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: DEFIBITCH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DEFIBITCH>(arg0, 6, b"DEFIBITCH", b"DEFIBITCH", b"This is DEFIBITCH token", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DEFIBITCH>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DEFIBITCH>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

