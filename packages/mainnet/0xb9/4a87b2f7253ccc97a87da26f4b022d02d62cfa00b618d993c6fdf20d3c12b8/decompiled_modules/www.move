module 0xb94a87b2f7253ccc97a87da26f4b022d02d62cfa00b618d993c6fdf20d3c12b8::www {
    struct WWW has drop {
        dummy_field: bool,
    }

    fun init(arg0: WWW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WWW>(arg0, 9, b"WWW", b"WWW", b"SSDS", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://uploader.irys.xyz/8Mb7Knrx3bk1CSJD2XfGXhN3n6fxAv96jy2uoWE6WzDw")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<WWW>(&mut v2, 1000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WWW>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WWW>>(v1);
    }

    // decompiled from Move bytecode v6
}

