module 0x38b5b02aa9b3ba0cb0cb9c7c7609fa2c54955cf9fe1174517ff2cc6e0302dd7a::sfr {
    struct SFR has drop {
        dummy_field: bool,
    }

    fun init(arg0: SFR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SFR>(arg0, 6, b"SFR", b"SALVIA FRANK DOG", b"A Dog In The Frank World", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731797689736.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SFR>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SFR>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

