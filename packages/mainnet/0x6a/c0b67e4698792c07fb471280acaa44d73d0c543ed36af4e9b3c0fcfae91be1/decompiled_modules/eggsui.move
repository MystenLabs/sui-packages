module 0x6ac0b67e4698792c07fb471280acaa44d73d0c543ed36af4e9b3c0fcfae91be1::eggsui {
    struct EGGSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: EGGSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EGGSUI>(arg0, 9, b"EGGSUI", x"f09fa59a456767737569", b"Official token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<EGGSUI>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EGGSUI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<EGGSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

