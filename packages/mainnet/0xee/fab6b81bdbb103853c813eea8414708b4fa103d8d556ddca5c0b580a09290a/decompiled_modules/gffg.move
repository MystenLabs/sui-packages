module 0xeefab6b81bdbb103853c813eea8414708b4fa103d8d556ddca5c0b580a09290a::gffg {
    struct GFFG has drop {
        dummy_field: bool,
    }

    fun init(arg0: GFFG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GFFG>(arg0, 9, b"GFFG", b"HJH", b"ERTR", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/0fc5b9f8-cdf9-4cd7-8769-85c05064580e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GFFG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GFFG>>(v1);
    }

    // decompiled from Move bytecode v6
}

