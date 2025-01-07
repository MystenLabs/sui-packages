module 0xdf93928c733d209a6bbf380712175abf716e479d91382c797f10ee46ae263f96::lottie {
    struct LOTTIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: LOTTIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LOTTIE>(arg0, 6, b"Lottie", b"Lottie World", x"57656c636f6d6520746f204c6f747469657320776f726c642c2077686572652069747320616c6c2066756e2c20616c6c207468652074696d6521204c6f747469657320612070726f206174206b656570696e6720697420636f6f6c2c206d616b696e672077617665732c20616e6420656e6a6f79696e67206576657279206d6f6d656e742e20537469636b2061726f756e6420666f7220676f6f642074696d657320616e6420677265617420766962657320776974682065766572796f6e6573206661766f7269746520756e6465727761746572206275646479210a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/lottie_4539683736.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LOTTIE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LOTTIE>>(v1);
    }

    // decompiled from Move bytecode v6
}

