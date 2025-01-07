module 0x444c1f729f079c1ea010908b400775e67f3b551e768041d5ed2ef2200e26c5aa::mochi {
    struct MOCHI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOCHI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOCHI>(arg0, 6, b"MOCHI", b"Mochi on Sui", x"57656c6c2074686174207375636b732c207765206861766520746f20676f20746f20547572626f730a54686520666c7566666c792c207371756973687920616e642068756e67727920626c6f62206c6976696e67206869732062657374206c69666520696e207468652053756920756e6976657273650a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731752115682.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MOCHI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOCHI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

