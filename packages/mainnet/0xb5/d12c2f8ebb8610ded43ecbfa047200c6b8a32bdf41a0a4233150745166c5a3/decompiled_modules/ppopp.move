module 0xb5d12c2f8ebb8610ded43ecbfa047200c6b8a32bdf41a0a4233150745166c5a3::ppopp {
    struct PPOPP has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<PPOPP>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<PPOPP>>(0x2::coin::mint<PPOPP>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: PPOPP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PPOPP>(arg0, 6, b"PPOPP", b"PPOPP", b"This is DEFIBITCH token", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PPOPP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PPOPP>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

