module 0x7645522c45518ec07665c0e17f6dc3c2b95531fbf264927a2722fd1d8a77f5c7::tdog {
    struct TDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: TDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TDOG>(arg0, 6, b"TDOG", b"Turbos Dog", x"2454444f472c20537569277320616e6420547572626f732773206265737420646f6721205469726564207769746820486f7066756e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730954811339.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TDOG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TDOG>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

