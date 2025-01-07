module 0x52a5242fabb7c1136cdc8b4480fab3a540207228f173255ed79b42d155577a2e::four20690 {
    struct FOUR20690 has drop {
        dummy_field: bool,
    }

    fun init(arg0: FOUR20690, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FOUR20690>(arg0, 6, b"420690", b"Pepe", b"pePE PePe", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://images.hop.ag/ipfs/QmT3n9QXTeUQFVHGUGBeKCDT94S5HJJ6jHtYk99V5RyQ14")), arg1);
        0x2::transfer::public_transfer<0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::Connector<FOUR20690>>(0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::new<FOUR20690>(2412683017720759672, v0, v1, 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), 0x2::tx_context::sender(arg1), arg1), @0xfa6d14378e545d7da62d15f7f1b5ac26ed9b2d7ffa6b232b245ffe7645591e91);
    }

    // decompiled from Move bytecode v6
}

