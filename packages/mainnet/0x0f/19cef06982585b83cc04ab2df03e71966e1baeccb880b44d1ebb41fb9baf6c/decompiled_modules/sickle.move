module 0xf19cef06982585b83cc04ab2df03e71966e1baeccb880b44d1ebb41fb9baf6c::sickle {
    struct SICKLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SICKLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SICKLE>(arg0, 6, b"SICKLE", b"Sui Pickle", b"Meet $SICKLE, the Sui Pickle doing pickle things. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/PP_97_776159dedd.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SICKLE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SICKLE>>(v1);
    }

    // decompiled from Move bytecode v6
}

