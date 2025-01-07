module 0x4cab4ce94206cfcae4e17d0a2c54dead5f873d933e0909e0cacb5c71c49c0bd7::fduck {
    struct FDUCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: FDUCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FDUCK>(arg0, 6, b"FDUCK", b"Flower Duck", x"49276d206120466c6f776572204475636b2064726970206f6e206d6520616e64206c6574206d652067726f77210a2353554920", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Photo_27_9_24_6_27_55_PM_35c7fcd82e.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FDUCK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FDUCK>>(v1);
    }

    // decompiled from Move bytecode v6
}

