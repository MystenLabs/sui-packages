module 0x439780efced34ca4496dbb4ab672ca54d6233259ca081ab8be82231b3dadc487::saigojo {
    struct SAIGOJO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAIGOJO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SAIGOJO>(arg0, 9, b"SAIGOJO", b"Gojo", b"Just try it....plz", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/13dd9a95-e60a-41b1-80df-2fdaed994638.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAIGOJO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SAIGOJO>>(v1);
    }

    // decompiled from Move bytecode v6
}

