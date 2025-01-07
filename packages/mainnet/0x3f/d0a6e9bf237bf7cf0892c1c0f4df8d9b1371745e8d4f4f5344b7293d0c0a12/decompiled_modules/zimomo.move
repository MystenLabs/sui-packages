module 0x3fd0a6e9bf237bf7cf0892c1c0f4df8d9b1371745e8d4f4f5344b7293d0c0a12::zimomo {
    struct ZIMOMO has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZIMOMO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZIMOMO>(arg0, 9, b"ZIMOMO", b"Sui Zimomo", b"did you know me?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pump.mypinata.cloud/ipfs/QmaRGpo193nRtV2MdgNw4XkFGpknbJ2S4823AMtRj67t2i?img-width=256&img-dpr=2&img-onerror=redirect")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<ZIMOMO>(&mut v2, 20000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZIMOMO>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ZIMOMO>>(v1);
    }

    // decompiled from Move bytecode v6
}

