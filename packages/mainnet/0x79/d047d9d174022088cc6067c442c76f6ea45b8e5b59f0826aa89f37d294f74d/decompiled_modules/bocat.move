module 0x79d047d9d174022088cc6067c442c76f6ea45b8e5b59f0826aa89f37d294f74d::bocat {
    struct BOCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOCAT>(arg0, 6, b"BOCAT", b"Book of Cats", b"Book of Cats is a unique token for cat lovers, featuring a collection of cats securely stored on our site.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://images.hop.ag/ipfs/QmNpqTpCjdkZXwo7JhTF1wffLUgsX2xJrt6pioHTus5Bz9")), arg1);
        0x2::transfer::public_transfer<0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::Connector<BOCAT>>(0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::new<BOCAT>(14735419886622178368, v0, v1, 0x1::string::utf8(b"https://x.com/BocatWtf"), 0x1::string::utf8(b"https://bocat.xyz/"), 0x1::string::utf8(b"https://t.me/BoCatTGPortal"), 0x2::tx_context::sender(arg1), arg1), @0xfa6d14378e545d7da62d15f7f1b5ac26ed9b2d7ffa6b232b245ffe7645591e91);
    }

    // decompiled from Move bytecode v6
}

