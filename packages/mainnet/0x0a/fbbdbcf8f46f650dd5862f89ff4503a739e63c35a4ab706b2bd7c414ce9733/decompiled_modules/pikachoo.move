module 0xafbbdbcf8f46f650dd5862f89ff4503a739e63c35a4ab706b2bd7c414ce9733::pikachoo {
    struct PIKACHOO has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIKACHOO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PIKACHOO>(arg0, 9, b"PIKACHOO", b"Sui Pikachoo", b"pikachoo with autism", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pump.mypinata.cloud/ipfs/QmcGVMSyTsbEHDq8knhyT4Ni8dTYTt7wDef6tLzGcYSDoE?img-width=256&img-dpr=2&img-onerror=redirect")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PIKACHOO>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PIKACHOO>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PIKACHOO>>(v1);
    }

    // decompiled from Move bytecode v6
}

