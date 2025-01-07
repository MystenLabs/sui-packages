module 0x4d9be88cbae13afaa5dc54e084718d0bd5c5f2b58315ed34c57b9b2c55e9955a::meoeme {
    struct MEOEME has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEOEME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEOEME>(arg0, 9, b"MEOEME", b"MEOEaaaaaa", b"MEOEMEO", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pump-fun-7k-dev.nysm.work/api/file-upload/fba90d669bf2447f8a9daca999faa20dblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MEOEME>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEOEME>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

