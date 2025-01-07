module 0x7b1e8c3c18168f7c6ba456d957443924cceffd3ccafe0831adfc256533ca4fce::suiaaa {
    struct SUIAAA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIAAA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIAAA>(arg0, 6, b"SUIAAA", b"Sui AAA", b"SuiAAA SuiAAA SuiAAA SuiAAA SuiAAA SuiAAA SuiAAA SuiAAA SuiAAA SuiAAA SuiAAA SuiAAA SuiAAA SuiAAA SuiAAA SuiAAA SuiAAA SuiAAA SuiAAA SuiAAA SuiAAA SuiAAA SuiAAA SuiAAA SuiAAA SuiAAA SuiAAA SuiAAA ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000106853_9a0a8e5791.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIAAA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIAAA>>(v1);
    }

    // decompiled from Move bytecode v6
}

