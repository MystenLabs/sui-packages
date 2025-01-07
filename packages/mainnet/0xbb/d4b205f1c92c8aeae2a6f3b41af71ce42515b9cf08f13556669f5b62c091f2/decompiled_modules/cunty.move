module 0xbbd4b205f1c92c8aeae2a6f3b41af71ce42515b9cf08f13556669f5b62c091f2::cunty {
    struct CUNTY has drop {
        dummy_field: bool,
    }

    fun init(arg0: CUNTY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CUNTY>(arg0, 6, b"CUNTY", b"Cunty The Cat", b"Cunty tokenomics dey tight! With the scarcity plan dem put, as more people dey buy, the price go shoot up like rocket.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Cunty_8cb9b80ad5.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CUNTY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CUNTY>>(v1);
    }

    // decompiled from Move bytecode v6
}

