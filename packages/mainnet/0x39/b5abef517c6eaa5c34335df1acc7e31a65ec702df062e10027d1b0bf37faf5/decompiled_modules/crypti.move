module 0x39b5abef517c6eaa5c34335df1acc7e31a65ec702df062e10027d1b0bf37faf5::crypti {
    struct CRYPTI has drop {
        dummy_field: bool,
    }

    fun init(arg0: CRYPTI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CRYPTI>(arg0, 9, b"CRYPTI", b"Cryp", b"NEW MEM", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/887589db635ab02248affc8d29fd476cblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CRYPTI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CRYPTI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

