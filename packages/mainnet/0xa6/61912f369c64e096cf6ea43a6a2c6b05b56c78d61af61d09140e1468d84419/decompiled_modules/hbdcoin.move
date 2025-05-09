module 0xa661912f369c64e096cf6ea43a6a2c6b05b56c78d61af61d09140e1468d84419::hbdcoin {
    struct HBDCOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: HBDCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HBDCOIN>(arg0, 6, b"HBDCoin", b"Happy Birthday Coin", x"546f646179206973206d792062697274686461792e20596574207365656d732065766572796f6e65206973206275737920616e6420666f7267657420746f206772656574206d652e200a0a4a75737420627579202431206f66207468697320636f696e206173206120677265657420746f206d652e200a0a5468616e6b732e200a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1746829104150.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HBDCOIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HBDCOIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

