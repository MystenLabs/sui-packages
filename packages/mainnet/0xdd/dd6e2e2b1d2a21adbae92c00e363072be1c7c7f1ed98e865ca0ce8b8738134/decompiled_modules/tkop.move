module 0xdddd6e2e2b1d2a21adbae92c00e363072be1c7c7f1ed98e865ca0ce8b8738134::tkop {
    struct TKOP has drop {
        dummy_field: bool,
    }

    fun init(arg0: TKOP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TKOP>(arg0, 9, b"TKOP", b"The King Of Pineapple", b"The King of Pineapple rules with sweet authority and a thorny crown, his golden rind sparkling like a treasure chest in the sun. Holding a shining Bitcoin high, he declares it the fruit of the new age, ready to juice up his tropical kingdoms economy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/a6a3c3fc956f7fd6f173b78baddd5921blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TKOP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TKOP>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

