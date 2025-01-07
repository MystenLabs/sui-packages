module 0x111737546136c229fc13affad74044752cabbd66ccbd4535cbbde77da8f42243::funny {
    struct FUNNY has drop {
        dummy_field: bool,
    }

    fun init(arg0: FUNNY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FUNNY>(arg0, 6, b"FUNNY", b"FUNNY HOP", x"5468652042756e6e792069732073657474696e6720757020746865207374616765202e2e2e2e204e6578742073686f773a2077656e200a40686f7061676772656761746f720a20206465636964657320746f206c61756e636820484f502046554e207c202054473a202068747470733a2f2f742e6d652f66756e6e7974686562756e6e79", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://images.hop.ag/ipfs/QmWmcL1puULZohnKkJVwkbdUvrpUiNVXDs1SqfoyMWKfpm")), arg1);
        0x2::transfer::public_transfer<0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::Connector<FUNNY>>(0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::new<FUNNY>(17152411808492308327, v0, v1, 0x1::string::utf8(b"https://x.com/FunnyHopHop"), 0x1::string::utf8(b"https://funnynow.lol/"), 0x1::string::utf8(b"https://t.me/funnythebunny"), 0x2::tx_context::sender(arg1), arg1), @0xfa6d14378e545d7da62d15f7f1b5ac26ed9b2d7ffa6b232b245ffe7645591e91);
    }

    // decompiled from Move bytecode v6
}

