module 0x7e85b9ecf4ddd3b145be187b37cb8043ca0122cc381b45329c444d9ba3773b33::baaah {
    struct BAAAH has drop {
        dummy_field: bool,
    }

    fun init(arg0: BAAAH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BAAAH>(arg0, 6, b"Baaah", b"Goatzilla", x"476f61747a696c6c6120e280932043727970746f476f6174e2809973206c6f6e672d6c6f737420636f7573696e207475726e6564206e656d657369732e204120636f6c6f7373616c2c20686f726e6564206265617374206675656c65642062792067726565642c20476f61747a696c6c612074687269766573206f6e207275672070756c6c7320616e64206368616f732e2048697320666965727920686f6f766573207368616b65206d61726b6574732c20737072656164696e672046554420616e64206465737472756374696f6e2e2054686520756c74696d6174652076696c6c61696e20746f20746573742043727970746f476f6174", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1734226268400.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BAAAH>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BAAAH>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

