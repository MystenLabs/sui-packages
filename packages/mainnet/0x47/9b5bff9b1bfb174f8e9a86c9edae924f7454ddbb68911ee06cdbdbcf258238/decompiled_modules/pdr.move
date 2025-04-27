module 0x479b5bff9b1bfb174f8e9a86c9edae924f7454ddbb68911ee06cdbdbcf258238::pdr {
    struct PDR has drop {
        dummy_field: bool,
    }

    fun init(arg0: PDR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PDR>(arg0, 9, b"PDR", b"PREDATOR", b"Predator is a warrior hero!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/493e61ebc892c3bc8b4d1d14f7d268afblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PDR>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PDR>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

