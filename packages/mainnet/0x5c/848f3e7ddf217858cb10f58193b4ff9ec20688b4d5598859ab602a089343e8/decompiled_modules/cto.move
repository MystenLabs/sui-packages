module 0x5c848f3e7ddf217858cb10f58193b4ff9ec20688b4d5598859ab602a089343e8::cto {
    struct CTO has drop {
        dummy_field: bool,
    }

    fun init(arg0: CTO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CTO>(arg0, 6, b"CTO", b"Decentralized", x"446563656e7472616c697a6564206973207468652066757475726520616e6420796f7520686176652074686520706f77657220746f20636f6e74726f6c20796f7572200a64657374696e792e20", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_2054_f907e8cdb9.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CTO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CTO>>(v1);
    }

    // decompiled from Move bytecode v6
}

