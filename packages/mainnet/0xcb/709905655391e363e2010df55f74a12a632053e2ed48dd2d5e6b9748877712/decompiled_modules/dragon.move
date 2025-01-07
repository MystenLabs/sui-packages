module 0xcb709905655391e363e2010df55f74a12a632053e2ed48dd2d5e6b9748877712::dragon {
    struct DRAGON has drop {
        dummy_field: bool,
    }

    fun init(arg0: DRAGON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DRAGON>(arg0, 6, b"Dragon", b"Totem-Dragon", b"Dragon is a mythological creature with great symbolic significance, which is often regarded as a symbol of power, dignity and auspiciousness. Unlike Western dragons, Chinese dragons are usually depicted as long, snake-shaped, four-clawed and capable of controlling water, rain and wind.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://images.hop.ag/ipfs/Qme4VYBTkrRKRD2qt29QTK5rg5h5jx9BGAcHzE2CgoUAWc")), arg1);
        0x2::transfer::public_transfer<0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::Connector<DRAGON>>(0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::new<DRAGON>(8440128694340373650, v0, v1, 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), 0x2::tx_context::sender(arg1), arg1), @0xfa6d14378e545d7da62d15f7f1b5ac26ed9b2d7ffa6b232b245ffe7645591e91);
    }

    // decompiled from Move bytecode v6
}

