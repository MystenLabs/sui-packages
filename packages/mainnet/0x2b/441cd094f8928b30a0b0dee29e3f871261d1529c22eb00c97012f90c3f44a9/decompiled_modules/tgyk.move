module 0x2b441cd094f8928b30a0b0dee29e3f871261d1529c22eb00c97012f90c3f44a9::tgyk {
    struct TGYK has drop {
        dummy_field: bool,
    }

    fun init(arg0: TGYK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TGYK>(arg0, 9, b"TGYK", b"kui7yrk", b"tsystyk", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/3610fc9edee7baf13bb80c4d752ffa85blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TGYK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TGYK>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

