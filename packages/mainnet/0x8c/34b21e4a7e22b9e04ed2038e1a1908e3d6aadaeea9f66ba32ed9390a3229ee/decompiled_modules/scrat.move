module 0x8c34b21e4a7e22b9e04ed2038e1a1908e3d6aadaeea9f66ba32ed9390a3229ee::scrat {
    struct SCRAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCRAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCRAT>(arg0, 6, b"SCRAT", b"Christmas Pnut", x"487573746c696e67206c696b652061206c6567656e642c2063686173696e672074686174207361637265642061636f726e207768696c652077652063686173652074686f7365206761696e732e20537472617020696e2c2061706573202024534352415473206c656164696e6720746865206368617267652e204c6574732073656e6420697420746f20746865206d6f6f6e20616e64206261672074686f73652061636f726e7320616e64206761696e7320666f722074686520737175616421200a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/3c3_Mo4p_400x400_37ef90f60a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCRAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SCRAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

