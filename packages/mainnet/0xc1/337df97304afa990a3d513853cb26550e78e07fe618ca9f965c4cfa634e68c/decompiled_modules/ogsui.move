module 0xc1337df97304afa990a3d513853cb26550e78e07fe618ca9f965c4cfa634e68c::ogsui {
    struct OGSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: OGSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OGSUI>(arg0, 6, b"OGSui", b"OnlyGranSui", x"57686f206e6565647320686f74206261626573207768656e20796f7520676f742061206772616e646d6120696e20796f7572206c6976696e6720726f6f6d2077616974696e6720746f206265207365656e2e2e200a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241202_165154_074_083d3b0aa2.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OGSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OGSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

