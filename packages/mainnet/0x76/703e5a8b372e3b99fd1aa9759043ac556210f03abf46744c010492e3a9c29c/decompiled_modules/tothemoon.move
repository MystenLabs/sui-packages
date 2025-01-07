module 0x76703e5a8b372e3b99fd1aa9759043ac556210f03abf46744c010492e3a9c29c::tothemoon {
    struct TOTHEMOON has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOTHEMOON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOTHEMOON>(arg0, 9, b"TOTHEMOON", b"SUIMOON", b"Sui will to the moon. SURE.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/6fd5234a-e15a-4f22-a265-37dcbdca424e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOTHEMOON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TOTHEMOON>>(v1);
    }

    // decompiled from Move bytecode v6
}

