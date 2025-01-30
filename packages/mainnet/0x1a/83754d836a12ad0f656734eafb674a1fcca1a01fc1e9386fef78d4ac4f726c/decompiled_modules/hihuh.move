module 0x1a83754d836a12ad0f656734eafb674a1fcca1a01fc1e9386fef78d4ac4f726c::hihuh {
    struct HIHUH has drop {
        dummy_field: bool,
    }

    fun init(arg0: HIHUH, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<HIHUH>(arg0, 6, b"HIHUH", b"By by SuiAI", b"Hvhvub", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/1000018746_070f446abf.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<HIHUH>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HIHUH>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

