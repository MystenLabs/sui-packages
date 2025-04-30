module 0x89bf77ecf2563a0d1273c0d42b50944232c39d8d816178899d021e64f61ebe4c::MAN {
    struct MAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAN>(arg0, 6, b"MAN", b"100 Man", b"Who would win? 100 Man or 1 Gorilla?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://uptos-pump.myfilebase.com/ipfs/QmWn7Eu3r8oVEs2zEPwBJ29JrSZjs259gNESPfc1brj1Kf")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MAN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

