module 0x5ac5e4d6453c006d6ba0a6eb3936c457c55a4991058c9447a491abe5c40e184::snut {
    struct SNUT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNUT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SNUT>(arg0, 6, b"$SNUT", b"Sui Pnut", b"HAHAHAH YES !", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://images.hop.ag/ipfs/Qmbnpp7WVCfooUVPHWgQZAaPaHPDT2SpAuizdwiAiJjna4")), arg1);
        0x2::transfer::public_transfer<0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::Connector<SNUT>>(0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::new<SNUT>(423203810898383199, v0, v1, 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), 0x2::tx_context::sender(arg1), arg1), @0xfa6d14378e545d7da62d15f7f1b5ac26ed9b2d7ffa6b232b245ffe7645591e91);
    }

    // decompiled from Move bytecode v6
}

