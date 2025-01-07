module 0x60d597902a4b2e77c270fba3b8e58a0dea9d3443bd6bdfba440c3bee91da2656::mat {
    struct MAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAT>(arg0, 6, b"MAT", b"MATSUI", x"244d41542077617320626f726e206f7574206f66206120636f6d6d756e6974792d64726976656e20696e69746961746976652e2020496e73706972656420627920616e206561726c7920696465612c2061206465646963617465642067726f75702063616d6520746f67657468657220746f206275696c642061207468726976696e672073706163652e0a0a46726f6d206974732068756d626c6520626567696e6e696e67732c204d4154206861732067726f776e20696e746f20612070617373696f6e61746520636f6d6d756e69747920756e6974656420627920612073686172656420766973696f6e2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730989533645.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MAT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

