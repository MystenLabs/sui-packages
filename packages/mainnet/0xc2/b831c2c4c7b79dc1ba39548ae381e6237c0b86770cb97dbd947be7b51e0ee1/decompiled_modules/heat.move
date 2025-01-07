module 0xc2b831c2c4c7b79dc1ba39548ae381e6237c0b86770cb97dbd947be7b51e0ee1::heat {
    struct HEAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: HEAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HEAT>(arg0, 9, b"DEGREE", b"HEAT", b"Lets heat sui up, shall we? no road map, lp-tokens burned, upgrade cap - immutable", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://icon-library.com/images/fire-vector-icon-png_294525.jpg")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HEAT>>(v1);
        0x2::coin::mint_and_transfer<HEAT>(&mut v2, 10000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HEAT>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

