module 0x528add8dd3eee6ece8932ca6f351a2d1d5c3b04b945509dacb21cd696336ee07::ttwo {
    struct TTWO has drop {
        dummy_field: bool,
    }

    fun init(arg0: TTWO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TTWO>(arg0, 7, b"Ttwo", b"Test2", b"Test", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TTWO>(&mut v2, 9000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TTWO>>(v2, @0x7cee6c0695ea5f18b441028b1505db16d8be50b89c390806c11f55d98966530c);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TTWO>>(v1);
    }

    // decompiled from Move bytecode v6
}

