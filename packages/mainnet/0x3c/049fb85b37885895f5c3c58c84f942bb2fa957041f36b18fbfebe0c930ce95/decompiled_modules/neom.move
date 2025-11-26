module 0x3c049fb85b37885895f5c3c58c84f942bb2fa957041f36b18fbfebe0c930ce95::neom {
    struct NEOM has drop {
        dummy_field: bool,
    }

    fun init(arg0: NEOM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NEOM>(arg0, 6, b"NEOM", b"NEOM", b"Nemo debt token for repay, initially it should be 1:1 to usdt", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://oss.nemoprotocol.com/tokenNeom.svg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NEOM>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NEOM>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

