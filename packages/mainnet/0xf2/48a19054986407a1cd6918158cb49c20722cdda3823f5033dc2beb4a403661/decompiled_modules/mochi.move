module 0xf248a19054986407a1cd6918158cb49c20722cdda3823f5033dc2beb4a403661::mochi {
    struct MOCHI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOCHI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOCHI>(arg0, 6, b"MOCHI", b"Mochi", x"54686520666c7566666c792c207371756973687920616e642068756e67727920626c6f62206c6976696e67206869732062657374206c69666520696e207468652053756920756e697665727365207c204c61756e6368696e67206f6e20547572626f730a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731089592555.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MOCHI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOCHI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

