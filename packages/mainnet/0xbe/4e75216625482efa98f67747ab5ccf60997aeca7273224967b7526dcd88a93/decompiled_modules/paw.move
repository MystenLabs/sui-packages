module 0xbe4e75216625482efa98f67747ab5ccf60997aeca7273224967b7526dcd88a93::paw {
    struct PAW has drop {
        dummy_field: bool,
    }

    fun init(arg0: PAW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PAW>(arg0, 6, b"PAW", b"PawPaw", b"hop hop, grrr grr, woof woof", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://images.hop.ag/ipfs/QmVcgt1NRcAetTi3jHvrKscfaNQ5K5jJ83CzShbFk5qtRL")), arg1);
        0x2::transfer::public_transfer<0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::Connector<PAW>>(0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::new<PAW>(4319434530638012477, v0, v1, 0x1::string::utf8(b"https://x.com/PawPawSui"), 0x1::string::utf8(b"https://pawdog.fun"), 0x1::string::utf8(b"https://t.me/PawSui"), 0x2::tx_context::sender(arg1), arg1), @0xfa6d14378e545d7da62d15f7f1b5ac26ed9b2d7ffa6b232b245ffe7645591e91);
    }

    // decompiled from Move bytecode v6
}

