module 0x8b7aa115daaa980ac5476944d3971bce9731bc02380d2039f1bfb402fffa0fce::beluga {
    struct BELUGA has drop {
        dummy_field: bool,
    }

    fun init(arg0: BELUGA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BELUGA>(arg0, 6, b"$BELUGA", b"BELUGA", b"THE FIRST WHALE HOPPING IN THE SUI WATERS", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://images.hop.ag/ipfs/QmenaDAB4AqadRUbwnigf7oJA7A5e9bS3YnZY6gfc1XUX3")), arg1);
        0x2::transfer::public_transfer<0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::Connector<BELUGA>>(0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::new<BELUGA>(5385459358587294811, v0, v1, 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), 0x2::tx_context::sender(arg1), arg1), @0xfa6d14378e545d7da62d15f7f1b5ac26ed9b2d7ffa6b232b245ffe7645591e91);
    }

    // decompiled from Move bytecode v6
}

