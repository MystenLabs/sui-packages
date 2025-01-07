module 0xc38e6cf02b70cb2eeccc407ff8545d5c7a74bd13b1fbf1261958bc7d395bfa0e::turbos {
    struct TURBOS has drop {
        dummy_field: bool,
    }

    fun init(arg0: TURBOS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TURBOS>(arg0, 6, b"TURBOS", b"runitbackturbo", b"turbos", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732223018247.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TURBOS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TURBOS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

