module 0xa3272001289e68ddb87972d14b7c4482bdb33d1213275293016aa510943d9a13::dolphe {
    struct DOLPHE has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOLPHE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOLPHE>(arg0, 9, b"DOLPHE", b"Dolphe", b"Dolphe is a hybrid between a dolphin and Pepe, the legendary character from Matt Furie's Boys' club comic. He loves to \"APE\" and collects all the hottest bags on the SUI blockchain.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://orange-upper-booby-780.mypinata.cloud/ipfs/QmXb3X3d9GkpVUF4YtqudVZeSsPuqt5hvADomJXioeeLAH"))), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DOLPHE>>(v1);
        0x2::coin::mint_and_transfer<DOLPHE>(&mut v2, 1000000000000000000, @0x49f63e767e4d93a7b5d29d80f935790a14f8fb8812f76522391a63cbced88bb4, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<DOLPHE>>(v2);
    }

    // decompiled from Move bytecode v6
}

