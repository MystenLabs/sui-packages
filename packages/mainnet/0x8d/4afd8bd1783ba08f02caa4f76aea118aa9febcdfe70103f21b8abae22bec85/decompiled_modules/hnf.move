module 0x8d4afd8bd1783ba08f02caa4f76aea118aa9febcdfe70103f21b8abae22bec85::hnf {
    struct HNF has drop {
        dummy_field: bool,
    }

    fun init(arg0: HNF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HNF>(arg0, 6, b"$HNF", b"HopNOTfun", b"This token was created to protest the stupid hop team. All profits will be distributed among the holders. FUCK OFf HOP!!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://images.hop.ag/ipfs/QmTiNDjZ4hd1uJchrb48jEDqaZDiRNFpbfzKL3seP3so4K")), arg1);
        0x2::transfer::public_transfer<0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::Connector<HNF>>(0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::new<HNF>(2828179127507922182, v0, v1, 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), 0x2::tx_context::sender(arg1), arg1), @0xfa6d14378e545d7da62d15f7f1b5ac26ed9b2d7ffa6b232b245ffe7645591e91);
    }

    // decompiled from Move bytecode v6
}

