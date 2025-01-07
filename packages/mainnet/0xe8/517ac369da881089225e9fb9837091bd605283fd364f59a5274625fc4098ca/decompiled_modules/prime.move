module 0xe8517ac369da881089225e9fb9837091bd605283fd364f59a5274625fc4098ca::prime {
    struct PRIME has drop {
        dummy_field: bool,
    }

    fun init(arg0: PRIME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PRIME>(arg0, 6, b"PRIME", b"SuiTronPrime", x"48652069732074686520667574757265206f6620616c6c207472616e73666f726d6572732c2061667465722068697320466174686572204f7074696d757320686973206c656761637920697320746f2072756c652c20616e6420666967687420616761696e7374204d65676174726f6e20616e6420746865206175746f626f74732e20486520697320747261696e696e672c20616e6420676174686572696e672061207465616d20666f7220746865207570636f6d696e6720626174746c6573210a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/log_A_2_5be49cd649.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PRIME>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PRIME>>(v1);
    }

    // decompiled from Move bytecode v6
}

