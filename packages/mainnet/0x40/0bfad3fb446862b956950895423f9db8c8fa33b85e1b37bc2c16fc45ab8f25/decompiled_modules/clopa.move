module 0x400bfad3fb446862b956950895423f9db8c8fa33b85e1b37bc2c16fc45ab8f25::clopa {
    struct CLOPA has drop {
        dummy_field: bool,
    }

    fun init(arg0: CLOPA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CLOPA>(arg0, 6, b"CLOPA", b"SUI CLOPA", b"symbol of luck", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/CLOPA_5219ddcf3a.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CLOPA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CLOPA>>(v1);
    }

    // decompiled from Move bytecode v6
}

