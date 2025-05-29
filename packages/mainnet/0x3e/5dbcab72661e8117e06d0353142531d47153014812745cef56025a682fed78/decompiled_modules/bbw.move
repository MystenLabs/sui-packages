module 0x3e5dbcab72661e8117e06d0353142531d47153014812745cef56025a682fed78::bbw {
    struct BBW has drop {
        dummy_field: bool,
    }

    fun init(arg0: BBW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BBW>(arg0, 6, b"BBW", b"BabeWave", x"426162655761766520282442425729206973206120706978656c2d706f77657265642c20636f6d6d756e6974792d666972737420746f6b656e20726964696e67206f6e20707572652076696265732e204e6f20726f61646d61702c206a757374207761696675732c206d656d65732c20616e642066756e2e0a0a576520686f706520746f2067726f7720696e746f20736f6d657468696e67206d65616e696e6766756c20207769746820636861726974792c206d656d6520636f6e74657374732c206d65726368206769766561776179732c20616e64206d6f726520646f776e20746865206c696e652e0a0a4772616220796f757220666c6f617469652e20", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/babewave_logo_compressed_6dbf0e9935.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BBW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BBW>>(v1);
    }

    // decompiled from Move bytecode v6
}

