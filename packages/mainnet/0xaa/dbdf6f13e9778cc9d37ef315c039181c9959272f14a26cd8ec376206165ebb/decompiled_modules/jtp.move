module 0xaadbdf6f13e9778cc9d37ef315c039181c9959272f14a26cd8ec376206165ebb::jtp {
    struct JTP has drop {
        dummy_field: bool,
    }

    fun init(arg0: JTP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JTP>(arg0, 9, b"Jtp", b"Jtp ", b"Jtp Just testing the platform", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/887c69da243a7d15f77f82551b3d9e9ablob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JTP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JTP>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

