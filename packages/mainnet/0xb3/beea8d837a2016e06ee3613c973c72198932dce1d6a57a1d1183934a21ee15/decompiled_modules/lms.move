module 0xb3beea8d837a2016e06ee3613c973c72198932dce1d6a57a1d1183934a21ee15::lms {
    struct LMS has drop {
        dummy_field: bool,
    }

    fun init(arg0: LMS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LMS>(arg0, 9, b"LMS", b"LUMOS", b"Fun token that will light your future ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/4e9a5322-4b89-422b-b469-641b1e69609e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LMS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LMS>>(v1);
    }

    // decompiled from Move bytecode v6
}

