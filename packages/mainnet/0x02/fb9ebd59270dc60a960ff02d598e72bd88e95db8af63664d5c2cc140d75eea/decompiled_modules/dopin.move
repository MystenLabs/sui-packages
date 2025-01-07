module 0x2fb9ebd59270dc60a960ff02d598e72bd88e95db8af63664d5c2cc140d75eea::dopin {
    struct DOPIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOPIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOPIN>(arg0, 6, b"DOPIN", b"DOPIN on TURBOS", x"54686520646f70656420636f6d6d756e6974792070726f6a656374206d616b696e67207761766573206f6e20535549202121210a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730971034064.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DOPIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOPIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

