module 0x79f980ea57c68a99967557b6d9d10d51d5d1fcffa94db54fae09af2a267780f4::madwolf {
    struct MADWOLF has drop {
        dummy_field: bool,
    }

    fun init(arg0: MADWOLF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MADWOLF>(arg0, 6, b"MADWOLF", b"MadWolf", x"4d4144574f4c46202d204e6f74206a75737420616e6f74686572206d656d6520636f696e2e20546869732069732061206d6f76656d656e742e0a41206e6577206c6567656e6420726973657320736f6f6e0a4f6e6c7920746865207374726f6e676573742077696c6c2062652070617274206f66207468652066697273742068756e742e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000033934_63d541b272.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MADWOLF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MADWOLF>>(v1);
    }

    // decompiled from Move bytecode v6
}

