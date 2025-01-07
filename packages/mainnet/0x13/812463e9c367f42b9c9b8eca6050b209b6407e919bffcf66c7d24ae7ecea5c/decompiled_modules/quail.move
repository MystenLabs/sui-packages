module 0x13812463e9c367f42b9c9b8eca6050b209b6407e919bffcf66c7d24ae7ecea5c::quail {
    struct QUAIL has drop {
        dummy_field: bool,
    }

    fun init(arg0: QUAIL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<QUAIL>(arg0, 6, b"QUAIL", b"Quail AI", x"517561696c3a20596f7572204149204167656e7420666f72204f6e2d436861696e20616e642053656e74696d656e7420496e7369676874730a0a517561696c20697320616e2041492d64726976656e20746f6f6c2064657369676e656420746f20756e636f766572207468652062657374206f70706f7274756e697469657320696e207468652063727970746f206d61726b657420627920616e616c797a696e67206f6e2d636861696e206d65747269637320616e64206d61726b65742073656e74696d656e742e0a0a4b65792046656174757265733a0a4f6e2d436861696e20416e616c797369733a20547261636b7320746f6b656e206d6f", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1736000847761.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<QUAIL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<QUAIL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

