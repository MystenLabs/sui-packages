module 0xbe78c7a48d4b48f40835adeb2884428660df551d7f0debb41fb254da2ac0bfff::smmd {
    struct SMMD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMMD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMMD>(arg0, 6, b"Smmd", b"Sui Smoking mad dog", x"53756920536d6f6b696e67206d616420646f67200a20200a68747470733a2f2f742e6d652f537569536d6f6b696e674d6164646f670a0a68747470733a2f2f782e636f6d2f736d6f6b696e676d6164646f67", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000067402_5164d8c220.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMMD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SMMD>>(v1);
    }

    // decompiled from Move bytecode v6
}

