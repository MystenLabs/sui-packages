module 0xd96e6388efed3936d7eb87e56d7e0f7d79a079f4a7b8617871850d3f3c3e9a02::hopfomo {
    struct HOPFOMO has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOPFOMO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOPFOMO>(arg0, 6, b"HOPFOMO", b"FOMOONHOPFUN", b"This is your Frist FOMO on hopfun but not the last one", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://images.hop.ag/ipfs/Qmatv3A9BeHuB3CZCD7saRRfeJASPfmsmhPWwuQ4KVEnQg")), arg1);
        0x2::transfer::public_transfer<0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::Connector<HOPFOMO>>(0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::new<HOPFOMO>(1904774958767662005, v0, v1, 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), 0x2::tx_context::sender(arg1), arg1), @0xfa6d14378e545d7da62d15f7f1b5ac26ed9b2d7ffa6b232b245ffe7645591e91);
    }

    // decompiled from Move bytecode v6
}

