module 0xeab4c5275f3c30f30a9c163a2fe326216e17526726d13ba6d9af4383270eb50::biao {
    struct BIAO has drop {
        dummy_field: bool,
    }

    fun init(arg0: BIAO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BIAO>(arg0, 6, b"BIAO", b"Biao on Sui", x"5468652031737420244249414f206465706c6f796564206f6e205375692c20636f6d6d756e6974792d6d616e616765642e0a5468652068656972206170706172656e74202e2e2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/O_O_O_U_U_O_U_1_2dddb17ac9.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BIAO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BIAO>>(v1);
    }

    // decompiled from Move bytecode v6
}

