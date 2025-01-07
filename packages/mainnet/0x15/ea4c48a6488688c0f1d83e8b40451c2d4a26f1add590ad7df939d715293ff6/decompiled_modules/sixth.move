module 0x15ea4c48a6488688c0f1d83e8b40451c2d4a26f1add590ad7df939d715293ff6::sixth {
    struct SIXTH has drop {
        dummy_field: bool,
    }

    fun init(arg0: SIXTH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SIXTH>(arg0, 9, b"SIXTH", b"6thELEMENT", b"The 6th Element ($SIXTH) follows 5 elements before. Look through the symbol to figure it out. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d61da9f7-9c26-437b-91c0-14d15d61498e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SIXTH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SIXTH>>(v1);
    }

    // decompiled from Move bytecode v6
}

