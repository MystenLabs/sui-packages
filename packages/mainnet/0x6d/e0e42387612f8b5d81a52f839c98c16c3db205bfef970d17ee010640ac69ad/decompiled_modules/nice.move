module 0x6de0e42387612f8b5d81a52f839c98c16c3db205bfef970d17ee010640ac69ad::nice {
    struct NICE has drop {
        dummy_field: bool,
    }

    fun init(arg0: NICE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NICE>(arg0, 6, b"NICE", b"Nice House", b"The Nice House promotes health and wellness through all things N.I.C.E!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1751560332896.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NICE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NICE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

