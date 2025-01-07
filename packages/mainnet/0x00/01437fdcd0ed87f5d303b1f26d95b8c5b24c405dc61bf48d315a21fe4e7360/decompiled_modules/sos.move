module 0x1437fdcd0ed87f5d303b1f26d95b8c5b24c405dc61bf48d315a21fe4e7360::sos {
    struct SOS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SOS>(arg0, 6, b"SoS", b"Sassy Seal", x"54686973207365616c20616c776179732068617320736f6d657468696e6720746f2073617920616e64205945532c20776f756c64206a7564676520796f752e20546865205365616c206f662053617373206973207072696d656420616e6420726561647920746f20726174696ff09faba2f09faba20a0a4e6f74653a2050726f2d42756c6c20616e6420416e74692d426561727320", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730870343747.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SOS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

