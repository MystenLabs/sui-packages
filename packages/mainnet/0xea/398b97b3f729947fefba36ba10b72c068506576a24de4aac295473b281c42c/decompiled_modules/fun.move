module 0xea398b97b3f729947fefba36ba10b72c068506576a24de4aac295473b281c42c::fun {
    struct FUN has drop {
        dummy_field: bool,
    }

    fun init(arg0: FUN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FUN>(arg0, 6, b"FUN", b"FUN", x"4620697320666f7220467269656e64732077686f20646f20737475666620746f6765746865720a5520697320666f7220596f7520616e64204d650a4e20697320666f7220616e79776865726520617420616e7974696d6520617420616c6c20646f776e206865726520696e20746865206465657020626c756520736561", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://images.hop.ag/ipfs/QmUF6Yv6fB9XpFSTdYx1yCayyJ6CanWVq39MQoumYnKn2x")), arg1);
        0x2::transfer::public_transfer<0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::Connector<FUN>>(0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::new<FUN>(17321876210941653626, v0, v1, 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), 0x2::tx_context::sender(arg1), arg1), @0xfa6d14378e545d7da62d15f7f1b5ac26ed9b2d7ffa6b232b245ffe7645591e91);
    }

    // decompiled from Move bytecode v6
}

