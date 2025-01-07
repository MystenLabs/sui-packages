module 0xef7c0819484e0b6ffd7fbbaef81d425297b0df8155065ab19cb85c14305a96c::saed {
    struct SAED has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAED, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SAED>(arg0, 9, b"SAED", b"Saeed", b"Ghruejbebd hfjdjdb", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b43817ff-2bec-4480-855e-cdf598555d2c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAED>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SAED>>(v1);
    }

    // decompiled from Move bytecode v6
}

