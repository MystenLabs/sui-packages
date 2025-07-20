module 0x7df5baa3c8b5e1646d9d73b887a749d99d017b0a39865dc9ec3e560d83914f37::catz {
    struct CATZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATZ, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<CATZ>(arg0, 6, b"CATZ", b"RoboCatz", b"@suilaunchcoin $CATZ + RoboCatz https://t.co/pPEtqNkkQu", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/catz-9cxvqw.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CATZ>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATZ>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

