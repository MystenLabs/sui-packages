module 0xe0bb454911c926076f15fb8fcc0cb4ac16d1e3754e700d3abe867d39841abc24::trumpsui {
    struct TRUMPSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUMPSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUMPSUI>(arg0, 6, b"TRUMPSUI", b"TRUMPSUI", b"We will make SUI great Again", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://images.hop.ag/ipfs/QmfQmCpSA9aZ1oDSBkcHYwJNZgNFUktLqxCzEBR2rHVkyv")), arg1);
        0x2::transfer::public_transfer<0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::Connector<TRUMPSUI>>(0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::new<TRUMPSUI>(1760047875263921368, v0, v1, 0x1::string::utf8(b"https://x.com/Trump_sui"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"https://t.me/+sTgya2W13xJhMTM5"), 0x2::tx_context::sender(arg1), arg1), @0xfa6d14378e545d7da62d15f7f1b5ac26ed9b2d7ffa6b232b245ffe7645591e91);
    }

    // decompiled from Move bytecode v6
}

