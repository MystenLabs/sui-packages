module 0x93fe8c606040263d65a9288f4b8018fd14078ff486b871f45a0d705f1d2153d4::elnino {
    struct ELNINO has drop {
        dummy_field: bool,
    }

    fun init(arg0: ELNINO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ELNINO>(arg0, 6, b"ELNINO", x"454c204e49c3914f", b"Markets will never be the same.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1783077072125.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ELNINO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ELNINO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

