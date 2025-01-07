module 0x5d5149cf2e0f35f6dbbdd2f7ba878ad1c97086c75e6564c832c086d643e29af7::mhz {
    struct MHZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: MHZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MHZ>(arg0, 9, b"MHZ", b"Mehrzad", b"Mhz the best token becuse have good mood.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/80844389-4669-4f5f-af7d-e74512744a37.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MHZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MHZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

