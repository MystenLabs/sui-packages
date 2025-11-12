module 0x8ce6c04a2d8e48f732625dea2835e91aaa2cbe9c7ecb31dc7b279f11e62b4435::mycoin {
    struct MYCOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: MYCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MYCOIN>(arg0, 9, b"BA", b"Banana", b"sssssss", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://uploader.irys.xyz/8Mb7Knrx3bk1CSJD2XfGXhN3n6fxAv96jy2uoWE6WzDw")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MYCOIN>(&mut v2, 10000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MYCOIN>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MYCOIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

