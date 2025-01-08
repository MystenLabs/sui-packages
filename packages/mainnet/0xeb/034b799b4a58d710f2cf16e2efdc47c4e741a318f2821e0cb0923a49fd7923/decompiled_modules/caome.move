module 0xeb034b799b4a58d710f2cf16e2efdc47c4e741a318f2821e0cb0923a49fd7923::caome {
    struct CAOME has drop {
        dummy_field: bool,
    }

    fun init(arg0: CAOME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CAOME>(arg0, 9, b"CAOME", b"caomei", b"CAOMEICAOMEI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/353cd7b7eeb411580d645d7aead036abblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CAOME>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CAOME>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

