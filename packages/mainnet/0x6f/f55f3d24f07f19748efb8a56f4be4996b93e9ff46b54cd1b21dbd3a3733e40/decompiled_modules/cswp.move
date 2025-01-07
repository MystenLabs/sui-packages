module 0x6ff55f3d24f07f19748efb8a56f4be4996b93e9ff46b54cd1b21dbd3a3733e40::cswp {
    struct CSWP has drop {
        dummy_field: bool,
    }

    fun init(arg0: CSWP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CSWP>(arg0, 6, b"CSWP", b"cat sui with passport", x"74686520636174207375692077686f2c2061667465722074726176656c696e6720736f0a6d7563682c2077696c6c206e65656420746f20676574206869732074686972640a70617373706f72742c206765747320746f206b6e6f7720646966666572656e740a63756c747572657320616e6420636f6c6c65637473206d6f6d656e7473", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/cat_sui_with_passport_1934d23d6e.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CSWP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CSWP>>(v1);
    }

    // decompiled from Move bytecode v6
}

