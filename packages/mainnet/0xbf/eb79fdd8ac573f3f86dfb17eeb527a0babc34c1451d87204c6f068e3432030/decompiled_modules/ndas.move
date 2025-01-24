module 0xbfeb79fdd8ac573f3f86dfb17eeb527a0babc34c1451d87204c6f068e3432030::ndas {
    struct NDAS has drop {
        dummy_field: bool,
    }

    fun init(arg0: NDAS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NDAS>(arg0, 9, b"NDAS", b"National Digital Asset Stockpile", b"America is becoming a superpower thanks to Bitcoin!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmdmgmsAGAoK5Pw9ohndmcqCnNU4une3QrqdhzYrDKGrYx")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<NDAS>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NDAS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NDAS>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

