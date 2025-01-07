module 0x9072a6f8338a959ce642a4c93994d02e9206d140e2a494dbb687223396bd0e28::whl {
    struct WHL has drop {
        dummy_field: bool,
    }

    fun init(arg0: WHL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WHL>(arg0, 6, b"WHL", b"WHL1", b"Ecosystem: WHL1 Network combines speed, efficiency, and integration to provide a solution for decentralized applications, crypto payments, and smart contracts.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1734982256931.13")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WHL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WHL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

