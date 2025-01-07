module 0xcec311a6f2508cbd89420d1b391ef2c6d8d94447a31b08a32476026079af7285::dos {
    struct DOS has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOS>(arg0, 6, b"DOS", b"Doggy on Sui", b"just a doggy on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1735136140276.webp")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DOS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

