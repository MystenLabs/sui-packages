module 0x4965e62951d52596fdf82b82790fd7a1b8dcf0be8b870ef10d90ea024238edb0::fl {
    struct FL has drop {
        dummy_field: bool,
    }

    fun init(arg0: FL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FL>(arg0, 9, b"FL", b"Florida", b"Rescue team ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/672de419-08c3-44ad-9fca-8baee63952b6.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FL>>(v1);
    }

    // decompiled from Move bytecode v6
}

