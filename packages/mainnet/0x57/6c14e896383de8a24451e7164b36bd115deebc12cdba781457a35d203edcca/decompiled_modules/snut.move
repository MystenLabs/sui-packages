module 0x576c14e896383de8a24451e7164b36bd115deebc12cdba781457a35d203edcca::snut {
    struct SNUT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNUT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SNUT>(arg0, 6, b"Snut", b"Seal Squirrel", b"Partly seal Partly squirrel Fully cute - what better way to honor the late and great P'nut on Sui.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Snut_401d1ca800.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SNUT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SNUT>>(v1);
    }

    // decompiled from Move bytecode v6
}

