module 0xf56a4b3873046e4629e06a2a30b7a26842906fbf5b0d3e1c03daca94fec0afe7::hopdoge {
    struct HOPDOGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOPDOGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOPDOGE>(arg0, 6, b"HOPDoge", b"HOPDoge", b"First Doge ON HOP", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://images.hop.ag/ipfs/QmdZP6M6z641fz4jynew9UjTVjrC4B1mBo8M4ZuA3hyL85")), arg1);
        0x2::transfer::public_transfer<0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::Connector<HOPDOGE>>(0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::new<HOPDOGE>(17603119726593234351, v0, v1, 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), 0x2::tx_context::sender(arg1), arg1), @0xfa6d14378e545d7da62d15f7f1b5ac26ed9b2d7ffa6b232b245ffe7645591e91);
    }

    // decompiled from Move bytecode v6
}

