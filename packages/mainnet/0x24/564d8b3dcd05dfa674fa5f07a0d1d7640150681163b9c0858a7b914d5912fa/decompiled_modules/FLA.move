module 0x24564d8b3dcd05dfa674fa5f07a0d1d7640150681163b9c0858a7b914d5912fa::FLA {
    struct FLA has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<FLA>, arg1: 0x2::coin::Coin<FLA>) {
        0x2::coin::burn<FLA>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<FLA>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<FLA>>(0x2::coin::mint<FLA>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: FLA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FLA>(arg0, 4, b"FLA", b"Future Life Architecture", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://lxtry1211.s3.us-west-1.amazonaws.com/fla_token.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FLA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

