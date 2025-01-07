module 0x662e6cdc3fdcae3a0063e9c4ab1d43d173ae401a2247849cb11dd5ea3b4d6a98::suitron {
    struct SUITRON has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUITRON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUITRON>(arg0, 6, b"SUITRON", b"SuiTronPrime", x"48652069732074686520667574757265206f6620616c6c207472616e73666f726d6572732c2061667465722068697320466174686572204f7074696d757320686973206c656761637920697320746f2072756c652c20616e6420666967687420616761696e7374204d65676174726f6e20616e6420746865206175746f626f74732e0a486520697320747261696e696e672c20616e6420676174686572696e672061207465616d20666f7220746865207570636f6d696e6720626174746c657321", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/log_A_2_edd5d31d7e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUITRON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUITRON>>(v1);
    }

    // decompiled from Move bytecode v6
}

