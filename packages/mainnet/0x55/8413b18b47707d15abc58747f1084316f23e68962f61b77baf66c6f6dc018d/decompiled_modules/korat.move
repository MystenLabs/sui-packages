module 0x558413b18b47707d15abc58747f1084316f23e68962f61b77baf66c6f6dc018d::korat {
    struct KORAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: KORAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KORAT>(arg0, 6, b"KORAT", b"Sui korat", x"54686520244b6f726174206973206120756e69717565206469676974616c206173736574206f6e2074686520537569206e6574776f726b2c2064657369676e656420746f2063617074757265206974732063756c747572616c20657373656e63650a0a244b6f72617420746f6b656e2063616e206265207573656420666f72207472616e73616374696f6e732077697468696e20746865205375692065636f73797374656d2c20656e61626c696e672061636365737320746f206578636c7573697665206576656e747320616e642073657276696365732e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20241003_155919_0ecb0962d4.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KORAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KORAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

