module 0x4894f7678aadd121982b1cf8ae93c9dc4830276466531061458c70d12478356b::nohop {
    struct NOHOP has drop {
        dummy_field: bool,
    }

    fun init(arg0: NOHOP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NOHOP>(arg0, 6, b"NOHOP", b"No-Hop", b"$NOHOP for hop.fun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730954186009.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NOHOP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NOHOP>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

