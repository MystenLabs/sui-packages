module 0x9b1d16c327fea4f34fa8cda1c84a99a4b63a63c4ec4d4d7c886a5183d398ac47::sdgg {
    struct SDGG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SDGG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SDGG>(arg0, 9, b"SDGG", b"GSG", b"HFG", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/179befd1-5cb3-4019-ad67-b221d2192708.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SDGG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SDGG>>(v1);
    }

    // decompiled from Move bytecode v6
}

