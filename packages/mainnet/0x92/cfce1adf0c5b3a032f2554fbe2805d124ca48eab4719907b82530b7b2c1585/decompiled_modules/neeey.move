module 0x92cfce1adf0c5b3a032f2554fbe2805d124ca48eab4719907b82530b7b2c1585::neeey {
    struct NEEEY has drop {
        dummy_field: bool,
    }

    fun init(arg0: NEEEY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NEEEY>(arg0, 9, b"NEEEY", b"Pi", b"Ghygfff", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e9ed628b-16e2-493f-9066-063bac021b2b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NEEEY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NEEEY>>(v1);
    }

    // decompiled from Move bytecode v6
}

