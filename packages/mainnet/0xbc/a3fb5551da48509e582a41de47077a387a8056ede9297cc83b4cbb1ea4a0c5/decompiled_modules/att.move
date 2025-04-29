module 0xbca3fb5551da48509e582a41de47077a387a8056ede9297cc83b4cbb1ea4a0c5::att {
    struct ATT has drop {
        dummy_field: bool,
    }

    fun init(arg0: ATT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ATT>(arg0, 9, b"ATT", b"anti trans trump", b"Will be trump", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/d890bb805f10c13c7700f52c68875dcdblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ATT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ATT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

