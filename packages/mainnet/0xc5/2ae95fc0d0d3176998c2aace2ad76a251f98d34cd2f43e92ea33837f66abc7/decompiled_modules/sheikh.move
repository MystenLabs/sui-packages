module 0xc52ae95fc0d0d3176998c2aace2ad76a251f98d34cd2f43e92ea33837f66abc7::sheikh {
    struct SHEIKH has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHEIKH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHEIKH>(arg0, 6, b"$SHEIKH", b"SHIEKH ZACK MORRIS", b"SHEIKH ZACK ON SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://images.hop.ag/ipfs/QmUyRaShHAaRyZoKn2tkxgnnMa4QvQLfmkMu9bewBjaXkN")), arg1);
        0x2::transfer::public_transfer<0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::Connector<SHEIKH>>(0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::new<SHEIKH>(3317197080541489204, v0, v1, 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), 0x2::tx_context::sender(arg1), arg1), @0xfa6d14378e545d7da62d15f7f1b5ac26ed9b2d7ffa6b232b245ffe7645591e91);
    }

    // decompiled from Move bytecode v6
}

