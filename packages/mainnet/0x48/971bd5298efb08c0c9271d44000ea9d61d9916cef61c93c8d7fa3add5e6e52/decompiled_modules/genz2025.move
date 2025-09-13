module 0x48971bd5298efb08c0c9271d44000ea9d61d9916cef61c93c8d7fa3add5e6e52::genz2025 {
    struct GENZ2025 has drop {
        dummy_field: bool,
    }

    fun init(arg0: GENZ2025, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GENZ2025>(arg0, 6, b"GenZ2025", b"Nepal GenZ", x"497427732061206d6f6d656e746f20746f2072656d656d626572206f6e65206f6620746865206772656174657374207265766f6c7574696f6e20746861742068617070656e656420696e203230323520616e64206368616e6765642068756d616e20686973746f727920616e6420417369616e20686973746f727920696e20706172746963756c61722c20666f72657665722e0a57652061726520676f696e6720746f2072656d656d62657220697420666f7220796561727320746f20636f6d652e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1757759827165.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GENZ2025>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GENZ2025>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

