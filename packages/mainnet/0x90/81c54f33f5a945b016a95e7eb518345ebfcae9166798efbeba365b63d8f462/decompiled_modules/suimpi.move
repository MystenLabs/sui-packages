module 0x9081c54f33f5a945b016a95e7eb518345ebfcae9166798efbeba365b63d8f462::suimpi {
    struct SUIMPI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIMPI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIMPI>(arg0, 6, b"SuimPi", b"SuimPi Pickle", b"SuimPi Pickle ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Designer_4_7b385ecee3.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIMPI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIMPI>>(v1);
    }

    // decompiled from Move bytecode v6
}

