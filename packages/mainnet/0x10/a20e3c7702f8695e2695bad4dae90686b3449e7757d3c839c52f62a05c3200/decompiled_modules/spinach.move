module 0x10a20e3c7702f8695e2695bad4dae90686b3449e7757d3c839c52f62a05c3200::spinach {
    struct SPINACH has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPINACH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPINACH>(arg0, 6, b"SPINACH", b"Popeye", b"Popeye the Sailor Man", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://images.hop.ag/ipfs/QmSdG4LtSM11izmJqLGr96PkgUjwL6NeZATfm9TD85zbv5")), arg1);
        0x2::transfer::public_transfer<0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::Connector<SPINACH>>(0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::new<SPINACH>(11268280705060055683, v0, v1, 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), 0x2::tx_context::sender(arg1), arg1), @0xfa6d14378e545d7da62d15f7f1b5ac26ed9b2d7ffa6b232b245ffe7645591e91);
    }

    // decompiled from Move bytecode v6
}

