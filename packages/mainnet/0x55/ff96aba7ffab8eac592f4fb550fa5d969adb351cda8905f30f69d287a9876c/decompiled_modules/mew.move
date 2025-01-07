module 0x55ff96aba7ffab8eac592f4fb550fa5d969adb351cda8905f30f69d287a9876c::mew {
    struct MEW has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEW>(arg0, 6, b"$MEW", b"MeowWooF", x"4a6f696e20746865204d4557205061636b20746f206265206170617274206f662074686520666173746573742067726f77696e6720636f6d6d756e697479206f6e2053554921200a544f204441204d45574e4e4e4e21", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://images.hop.ag/ipfs/QmQzsgpFsSLA1XV3yeAS2j2MxfdLUt4qR9CaGnHgVWAiRA")), arg1);
        0x2::transfer::public_transfer<0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::Connector<MEW>>(0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::new<MEW>(8247041000207045278, v0, v1, 0x1::string::utf8(b"https://x.com/MeowWoofMEW"), 0x1::string::utf8(b"https://meowwoof.net/"), 0x1::string::utf8(b"https://t.me/+tozJ-bNBQaxmMTlh"), 0x2::tx_context::sender(arg1), arg1), @0xfa6d14378e545d7da62d15f7f1b5ac26ed9b2d7ffa6b232b245ffe7645591e91);
    }

    // decompiled from Move bytecode v6
}

