module 0xe155731d37e1ba59e4e24e2aef3abe86f03b70f02ea94489d0f6b09c8f5bc712::mkgmkgmkg {
    struct MKGMKGMKG has drop {
        dummy_field: bool,
    }

    fun init(arg0: MKGMKGMKG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MKGMKGMKG>(arg0, 9, b"MKGMKGMKG", b"mkg", b"best", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/3d425edff2f6c99e5b3624861f68cfc6blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MKGMKGMKG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MKGMKGMKG>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

