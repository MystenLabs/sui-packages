module 0x28d1c63498fda1c06e97717af803f60d821f28993b5ac189e63deb89ca0d55f5::woof {
    struct WOOF has drop {
        dummy_field: bool,
    }

    fun init(arg0: WOOF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WOOF>(arg0, 9, b"WOOF", b"Lost Dogs", x"f09f9a80204c6f737420446f6773202d204e465420737572766976616c2067616d6520776974682024574f4f4620746f6b656e2120506c617920617320737472617920646f67732c206561726e207768696c6520796f7520706c6179207468726f7567682071756573747320616e64204e4654207472616465732e2042696720696e766573746d656e74206f70706f7274756e6974792c206a6f696e206e6f772120f09f9095f09f92a5", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/342189ea-7cbc-496e-8d95-5d5b89880c4f-IMG_5896.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WOOF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WOOF>>(v1);
    }

    // decompiled from Move bytecode v6
}

