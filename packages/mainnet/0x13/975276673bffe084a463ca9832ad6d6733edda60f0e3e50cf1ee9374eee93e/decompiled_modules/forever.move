module 0x13975276673bffe084a463ca9832ad6d6733edda60f0e3e50cf1ee9374eee93e::forever {
    struct FOREVER has drop {
        dummy_field: bool,
    }

    fun init(arg0: FOREVER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FOREVER>(arg0, 6, b"FOREVER", b"WEWONFOREVER", b"i am forever loved     i am forever worthy     i am forever healthy     i am forever blessed     i am forever grateful     i am forever evolving     i am forever protected", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/forever_cd733988c3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FOREVER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FOREVER>>(v1);
    }

    // decompiled from Move bytecode v6
}

