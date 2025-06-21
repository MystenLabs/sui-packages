module 0x4e840c436bf0950fae0518784ff537ee7b8734d0340198c88cbd14300a81fb96::bt {
    struct BT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BT>(arg0, 9, b"BT", b"BananaTool", b"create coin tool", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://uploader.irys.xyz/8Mb7Knrx3bk1CSJD2XfGXhN3n6fxAv96jy2uoWE6WzDw")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BT>(&mut v2, 10000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BT>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BT>>(v1);
    }

    // decompiled from Move bytecode v6
}

