module 0xfc804a20f1389396ede6c48377f6fc25c5b264c076c947b8fdd1fc3316fe978c::blob {
    struct BLOB has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLOB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLOB>(arg0, 6, b"BLOB", b"Blob On Sui", x"6c6f6f6b696e6720666f7220736f6d657468696e67206d6f7265206d656d6561626c65207468616e20626c6f6220756e64657220776174746572202e204e6f7468696e6720666f756e6420210a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731012802869.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BLOB>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLOB>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

