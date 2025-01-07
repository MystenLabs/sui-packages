module 0xf8ad698500b7f321c0ea685d460897987d5b531389d83bfa0b7842f852210e09::tigerr {
    struct TIGERR has drop {
        dummy_field: bool,
    }

    fun init(arg0: TIGERR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TIGERR>(arg0, 9, b"TIGERR", b"Tiger", b"Crying Tiger", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e9d1b2fd-1c32-4038-8ff3-f7f9f9567ad2.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TIGERR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TIGERR>>(v1);
    }

    // decompiled from Move bytecode v6
}

