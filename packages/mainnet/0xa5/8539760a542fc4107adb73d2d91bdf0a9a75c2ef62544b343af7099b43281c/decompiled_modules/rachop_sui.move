module 0xa58539760a542fc4107adb73d2d91bdf0a9a75c2ef62544b343af7099b43281c::rachop_sui {
    struct RACHOP_SUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: RACHOP_SUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RACHOP_SUI>(arg0, 6, b"rachop_sui", b"rachop", b"Hop fun first racoon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://images.hop.ag/ipfs/QmSGQUYn4MkWnYhmmQCaf7rWtNrd4zcsRt1UWr9HFZ1Mgp")), arg1);
        0x2::transfer::public_transfer<0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::Connector<RACHOP_SUI>>(0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::new<RACHOP_SUI>(7157411385835472186, v0, v1, 0x1::string::utf8(b"https://x.com/RachopSui"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), 0x2::tx_context::sender(arg1), arg1), @0xfa6d14378e545d7da62d15f7f1b5ac26ed9b2d7ffa6b232b245ffe7645591e91);
    }

    // decompiled from Move bytecode v6
}

