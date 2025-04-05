module 0x5c4510cea0e6bf2e2933391c23ca61b7e292e78fc39a17283c309299a8c06de7::krnd {
    struct KRND has drop {
        dummy_field: bool,
    }

    fun init(arg0: KRND, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KRND>(arg0, 9, b"KRND", b"Karandashyk", b"Rodion", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/63e37b0bf80e43db610cc05ce63edbbbblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KRND>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KRND>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

