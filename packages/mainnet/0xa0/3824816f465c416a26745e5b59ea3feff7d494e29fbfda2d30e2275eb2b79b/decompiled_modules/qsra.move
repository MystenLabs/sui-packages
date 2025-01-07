module 0xa03824816f465c416a26745e5b59ea3feff7d494e29fbfda2d30e2275eb2b79b::qsra {
    struct QSRA has drop {
        dummy_field: bool,
    }

    fun init(arg0: QSRA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<QSRA>(arg0, 6, b"QSRA", b"Squirac Coin on Sui", x"f09f90be202d2053717569526163436f696e20666f7220416e696d616c2057656c6661726520f09f8cbf0a556e6974696e6720766f6963657320746f2070726f7465637420616e6420737570706f727420746865206c6974746c65206865726f6573206f662074686520616e696d616c20776f726c642120f09f90bfefb88ff09fa497f09fa69d", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731423734528.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<QSRA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<QSRA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

