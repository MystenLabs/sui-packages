module 0x9c7247791b6185f4ca27040b2185f9733a5ebe722a5358bf5579571c2f1a1bca::plufo {
    struct PLUFO has drop {
        dummy_field: bool,
    }

    fun init(arg0: PLUFO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PLUFO>(arg0, 6, b"Plufo", b"Plufo Token", x"506c75666c6f2c20746865206d656d6520636f696e0a74686174206272696e67732066756e20616e642066696e616e63650a746f6765746865722120", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20241009_223028_f6abc64296.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PLUFO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PLUFO>>(v1);
    }

    // decompiled from Move bytecode v6
}

