module 0xfea33f6aa98650530e61347fe4e34b31d1cf4b3fbb02b0c09f110c950d873205::horse {
    struct HORSE has drop {
        dummy_field: bool,
    }

    fun init(arg0: HORSE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HORSE>(arg0, 6, b"HORSE", b"Suihorse", b"The chillest horse in the sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://images.hop.ag/ipfs/QmfLLvTxyZuCXGujr532hX89vK5rxqkyD5DDZxrwaDkThm")), arg1);
        0x2::transfer::public_transfer<0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::Connector<HORSE>>(0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::new<HORSE>(16316651794566709647, v0, v1, 0x1::string::utf8(b"https://x.com/thesuihorse"), 0x1::string::utf8(b"https://suihorse.site/"), 0x1::string::utf8(b"https://t.me/suihorselink"), 0x2::tx_context::sender(arg1), arg1), @0xfa6d14378e545d7da62d15f7f1b5ac26ed9b2d7ffa6b232b245ffe7645591e91);
    }

    // decompiled from Move bytecode v6
}

