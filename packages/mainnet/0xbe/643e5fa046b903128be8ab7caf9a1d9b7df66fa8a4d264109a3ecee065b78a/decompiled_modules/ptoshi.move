module 0xbe643e5fa046b903128be8ab7caf9a1d9b7df66fa8a4d264109a3ecee065b78a::ptoshi {
    struct PTOSHI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PTOSHI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PTOSHI>(arg0, 9, b"PTOSHI", b"IamSatoshi", b"Forbes just confirmed that HBO's documentary is saying Peter Todd is Satoshi", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ff552c23-4723-49d8-b63a-b52b16c5ae18.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PTOSHI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PTOSHI>>(v1);
    }

    // decompiled from Move bytecode v6
}

