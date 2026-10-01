module 0xd14c0219bcced8ab6aadb829456aa65fcfcbcd612fa75e4bdc321e522b00debc::riptoid {
    struct RIPTOID has drop {
        dummy_field: bool,
    }

    public fun creator() : address {
        @0x489e7b801fa43b8ba11038733e3909d3cdd6db3c21bd0e80dc9704f77c148f7d
    }

    fun init(arg0: RIPTOID, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<RIPTOID>(arg0, 9, 0x1::string::utf8(b"RIPTOID"), 0x1::string::utf8(b"RIPTOID"), 0x1::string::utf8(b"Fast liquidity token on Ript https://t.co/FVBhVoq5MT"), 0x1::string::utf8(b"https://pbs.twimg.com/media/HTj6nXabcAAzhwd.jpg"), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RIPTOID>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<RIPTOID>>(0x2::coin_registry::finalize<RIPTOID>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

