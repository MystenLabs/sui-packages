module 0x3c103b1ff0cef2147cd8f281de156588f12002e178439a01c02b2b216beb5d9c::qshp {
    struct QSHP has drop {
        dummy_field: bool,
    }

    fun init(arg0: QSHP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<QSHP>(arg0, 9, b"QSHP", b"QuantumShe", b"For tech-savvy herders.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/0c694bc8-c524-480b-a312-729f58929231.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<QSHP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<QSHP>>(v1);
    }

    // decompiled from Move bytecode v6
}

