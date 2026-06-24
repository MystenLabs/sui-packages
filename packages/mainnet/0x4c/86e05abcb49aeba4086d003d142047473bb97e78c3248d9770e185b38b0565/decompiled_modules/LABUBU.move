module 0x4c86e05abcb49aeba4086d003d142047473bb97e78c3248d9770e185b38b0565::LABUBU {
    struct LABUBU has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<LABUBU>, arg1: 0x2::coin::Coin<LABUBU>) {
        0x2::coin::burn<LABUBU>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<LABUBU>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<LABUBU>>(0x2::coin::mint<LABUBU>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: LABUBU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LABUBU>(arg0, 4, b"LABUBU", b"LABUBU Protocol", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://lxtry1211.s3.us-west-1.amazonaws.com/labubu_token.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LABUBU>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LABUBU>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

