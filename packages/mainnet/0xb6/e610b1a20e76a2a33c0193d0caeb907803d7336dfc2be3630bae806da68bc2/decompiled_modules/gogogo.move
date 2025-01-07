module 0xb6e610b1a20e76a2a33c0193d0caeb907803d7336dfc2be3630bae806da68bc2::gogogo {
    struct GOGOGO has drop {
        dummy_field: bool,
    }

    fun create_currency<T0: drop>(arg0: T0, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::TreasuryCap<T0> {
        let (v0, v1) = 0x2::coin::create_currency<T0>(arg0, 9, b"GOGO", b"gogogo", b"gogo gogo gogo", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<T0>>(v1);
        v0
    }

    fun init(arg0: GOGOGO, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = create_currency<GOGOGO>(arg0, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOGOGO>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<GOGOGO>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<GOGOGO>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

