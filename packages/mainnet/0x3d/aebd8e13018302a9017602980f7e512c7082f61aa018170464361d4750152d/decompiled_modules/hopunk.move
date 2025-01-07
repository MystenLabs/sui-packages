module 0x3daebd8e13018302a9017602980f7e512c7082f61aa018170464361d4750152d::hopunk {
    struct HOPUNK has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOPUNK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOPUNK>(arg0, 6, b"HoPunk", b"HoPunk", b"$HoPunk brings fun with adorable pet cuties.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://images.hop.ag/ipfs/QmQdEkttLHPfvBx7ptBhRaPKoTzAG1CUxgBqW9e8GZQWWc")), arg1);
        0x2::transfer::public_transfer<0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::Connector<HOPUNK>>(0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::new<HOPUNK>(4303297207491856122, v0, v1, 0x1::string::utf8(b"https://x.com/Hopfunpunk?t=E8bEbL5O9bCS1aSDh5jsDA&s=09"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), 0x2::tx_context::sender(arg1), arg1), @0xfa6d14378e545d7da62d15f7f1b5ac26ed9b2d7ffa6b232b245ffe7645591e91);
    }

    // decompiled from Move bytecode v6
}

