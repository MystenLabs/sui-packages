module 0x862ad528c781170e3eddf696e35eb921355c19e1f7508efa487db1393e3bc724::manon {
    struct MANON has drop {
        dummy_field: bool,
    }

    fun init(arg0: MANON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MANON>(arg0, 6, b"MANON", b"Mega Anon", b"we're hidden, don't experiment more, all very messed up, with the exception of $MANON", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreifjfcwigcngbq25dn4dciupw7adkbz5j57tbuv5hcbhcqwcox676i")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MANON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MANON>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

