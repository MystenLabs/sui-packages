module 0x7c15758cc11816f15c3d44c79b68d2a1f736f90a3fd8ece529e03a23174ed02b::hihi {
    struct HIHI has drop {
        dummy_field: bool,
    }

    fun init(arg0: HIHI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HIHI>(arg0, 9, b"HIHI", b"Serena", b"SRN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f3185fb4-651e-44ba-b63a-3926ccecb622.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HIHI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HIHI>>(v1);
    }

    // decompiled from Move bytecode v6
}

