module 0x1c2e7a595571f422c76541a3139fe7e54f6661f130d381e9da86fe327a7ca37c::onsec {
    struct ONSEC has drop {
        dummy_field: bool,
    }

    fun init(arg0: ONSEC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ONSEC>(arg0, 6, b"Onsec", b"OnsecAI", b"Onsec AI provides real-time AI-driven protection, detecting and neutralizing cyber threats before they strike.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1738345540885.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ONSEC>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ONSEC>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

