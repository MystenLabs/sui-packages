module 0xa6513ca92b29c52700be344c88b55b60a836bf8fb75ec1e0e637b4709c25e9c3::sdgg {
    struct SDGG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SDGG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SDGG>(arg0, 9, b"SDGG", b"GSG", b"HFG", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/54c42363-2315-4dfa-8a21-97532e8c954e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SDGG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SDGG>>(v1);
    }

    // decompiled from Move bytecode v6
}

