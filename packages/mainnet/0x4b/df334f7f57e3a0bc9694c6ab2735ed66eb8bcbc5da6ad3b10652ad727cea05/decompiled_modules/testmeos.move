module 0x4bdf334f7f57e3a0bc9694c6ab2735ed66eb8bcbc5da6ad3b10652ad727cea05::testmeos {
    struct TESTMEOS has drop {
        dummy_field: bool,
    }

    fun init(arg0: TESTMEOS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TESTMEOS>(arg0, 9, b"TESTMEOS", b"MeoMeo", b"Meo Meo ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/3fb40f7411b6f677506c804fb1e1392ablob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TESTMEOS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TESTMEOS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

