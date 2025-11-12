module 0x705f547cd2c370876d34fb30b63da6eee2f72b444ad85a6c7e098f9f5633cba9::bys {
    struct BYS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BYS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BYS>(arg0, 9, b"BYS", b"BY", b"WWWW", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://uploader.irys.xyz/8Mb7Knrx3bk1CSJD2XfGXhN3n6fxAv96jy2uoWE6WzDw")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BYS>(&mut v2, 1000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BYS>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BYS>>(v1);
    }

    // decompiled from Move bytecode v6
}

