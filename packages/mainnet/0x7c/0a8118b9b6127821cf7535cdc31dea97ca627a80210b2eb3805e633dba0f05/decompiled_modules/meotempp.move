module 0x7c0a8118b9b6127821cf7535cdc31dea97ca627a80210b2eb3805e633dba0f05::meotempp {
    struct MEOTEMPP has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEOTEMPP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEOTEMPP>(arg0, 9, b"MEOTEMPP", b"TEST", b"aaaa", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pump-fun-7k-dev.nysm.work/api/file-upload/d95ec0c00785c04caafa2bd103ee9aeeblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MEOTEMPP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEOTEMPP>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

