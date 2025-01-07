module 0x8349881f7288a1b2e1b021d3ee98004aa72345a4d9c90ad8b0aaf28f376e94ea::hjjana {
    struct HJJANA has drop {
        dummy_field: bool,
    }

    fun init(arg0: HJJANA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HJJANA>(arg0, 9, b"HJJANA", b"Lkha", b"Hbbx", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/85deeb03-27d2-433e-b8d4-b45faa5eb06a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HJJANA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HJJANA>>(v1);
    }

    // decompiled from Move bytecode v6
}

