module 0x493e430914f8a5987ccdee9943f867d5a41de83141e6554eb7a193708069d405::aid {
    struct AID has drop {
        dummy_field: bool,
    }

    fun init(arg0: AID, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<AID>(arg0, 6, b"AID", b"ARAPU by SuiAI", b"The only way to became a milionaire", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/0198_Laura_and_Daniel_1ef696324b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<AID>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AID>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

