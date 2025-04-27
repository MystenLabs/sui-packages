module 0x1c610171baf1ffb83ef33e6df8e683ff2702f66cc385127b398ee5fa66773ea4::wetc {
    struct WETC has drop {
        dummy_field: bool,
    }

    fun init(arg0: WETC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WETC>(arg0, 6, b"WETC", b"WETCOIN", x"574554434f494e206a75737420617065204920646f6e27742077616e7420746f2072756720796f7520746f206275792061207065616e75742049276d206865726520666f72206c6f6e67207465726d0a4f6e636520626f6e64656420726561647920746f2070617920746865204445580a526561647920746f2062757920626f6f7374", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/waet_6fa0d03563.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WETC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WETC>>(v1);
    }

    // decompiled from Move bytecode v6
}

