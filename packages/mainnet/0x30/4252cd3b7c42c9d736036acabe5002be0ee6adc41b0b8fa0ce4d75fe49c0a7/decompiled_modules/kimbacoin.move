module 0x304252cd3b7c42c9d736036acabe5002be0ee6adc41b0b8fa0ce4d75fe49c0a7::kimbacoin {
    struct KIMBACOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: KIMBACOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KIMBACOIN>(arg0, 9, b"KIMBACOIN", b"Kimba ", x"50726570c3a172617465207061726120756e20656d6f63696f6e616e7465207669616a6520616c206573706163696f2063726970746f6772c3a16669636f20636f6d6f206e756e636120616e746573206c6f20686162c3ad6173206578706572696d656e7461646f2e0a4b696d626120736520636f6e766572746972c3a120656e206c61207072696d65726120276d6f6e656461206465206d656d652720656e20616c63616e7a617220656c2076616c6f72206dc3a17320616c746f2064656c206d65726361646f2c20677261636961732061206e756573747261206f6665727461206c696d69746164612e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c792f518-2505-4a15-b9c1-777ba532b21e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KIMBACOIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KIMBACOIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

