module 0x76499054602200f4e4066bb28a3b6d55c9cc1dd46c1750617c7a38f0650ce0d::dino {
    struct DINO has drop {
        dummy_field: bool,
    }

    fun init(arg0: DINO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DINO>(arg0, 6, b"DINO", b"DINO", x"4f6e65206f66207468652066697273742062696767657374206d656d65636f696e73206f6e2053756920f09fa69657524141414141414141414141414141414141414141482120f09fa696", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://images.hop.ag/ipfs/QmbGUEdWeJ7cFNoCjA9pHAn8pedbQvbwtkn5QU3ptksX4w")), arg1);
        0x2::transfer::public_transfer<0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::Connector<DINO>>(0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::new<DINO>(1882110357280509557, v0, v1, 0x1::string::utf8(b"https://x.com/HopDinoSui"), 0x1::string::utf8(b"https://dinomemecoin.com/"), 0x1::string::utf8(b"https://t.me/HopDinoSui"), 0x2::tx_context::sender(arg1), arg1), @0xfa6d14378e545d7da62d15f7f1b5ac26ed9b2d7ffa6b232b245ffe7645591e91);
    }

    // decompiled from Move bytecode v6
}

