module 0x61ca9a7d8b78308c2484fef5f27b5cf28825e02d78dee6f7d85c59280f3016aa::doctor {
    struct DOCTOR has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOCTOR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOCTOR>(arg0, 6, b"DOCTOR", b"Doctor ai", b"$DOCTOR AI is an advanced AI-powered medical diagnostic system specializing in the analysis of medical imaging, including X-rays, MRI, CT scans, and ultrasounds", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20250111_184214_710_cf71b41d95.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOCTOR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOCTOR>>(v1);
    }

    // decompiled from Move bytecode v6
}

