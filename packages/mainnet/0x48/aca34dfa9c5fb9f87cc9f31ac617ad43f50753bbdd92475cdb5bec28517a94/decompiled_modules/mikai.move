module 0x48aca34dfa9c5fb9f87cc9f31ac617ad43f50753bbdd92475cdb5bec28517a94::mikai {
    struct MIKAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MIKAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MIKAI>(arg0, 6, b"MIKAI", b"Hatsune Miku AI", x"546869732070726f6a6563742061696d7320746f2063726561746520612063727970746f63757272656e637920666561747572696e672048617473756e65204d696b752c206120706f70756c6172207669727475616c2073696e67657220616e6420616e696d65206368617261637465722e0a2054686520676f616c20697320746f206f666665722061206e657720616e6420756e6971756520666f726d206f66206469676974616c2063757272656e637920746861742061707065616c7320746f2066616e73206f662048617473756e65204d696b7520616e6420746865207669727475616c2073696e6765722063756c747572652e0a0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_252ce60326.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MIKAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MIKAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

