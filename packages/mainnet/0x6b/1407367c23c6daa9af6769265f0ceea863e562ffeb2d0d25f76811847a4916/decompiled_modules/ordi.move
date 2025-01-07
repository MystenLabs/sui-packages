module 0x6b1407367c23c6daa9af6769265f0ceea863e562ffeb2d0d25f76811847a4916::ordi {
    struct ORDI has drop {
        dummy_field: bool,
    }

    fun init(arg0: ORDI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ORDI>(arg0, 9, b"ordi", b"ordi", b"Ordinals are a numbering scheme for satoshis that allows tracking and transferring individual sats.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://assets.coingecko.com/coins/images/30162/standard/ordi.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ORDI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ORDI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

