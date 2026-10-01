module 0x5b0d609c1dcad4f4ea24056c86038787cbbe0cee968b5b878f296a68d067f45d::obript {
    struct OBRIPT has drop {
        dummy_field: bool,
    }

    public fun creator() : address {
        @0x489e7b801fa43b8ba11038733e3909d3cdd6db3c21bd0e80dc9704f77c148f7d
    }

    fun init(arg0: OBRIPT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<OBRIPT>(arg0, 9, 0x1::string::utf8(b"OBRIPT"), 0x1::string::utf8(b"OurBlast Ript Test"), 0x1::string::utf8(b"OurBlast x RIPT integration test launch."), 0x1::string::utf8(b"https://ourblast.xyz/icon-192.png"), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OBRIPT>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<OBRIPT>>(0x2::coin_registry::finalize<OBRIPT>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

