module 0x54554c8bea73c022f0d22f6e92216809ca247125db6227b036287754dbd3c8ce::dden {
    struct DDEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: DDEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DDEN>(arg0, 9, b"DDEN", b"Deden", b"Dedenuhu", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/1a08c461-e5e2-40d5-9a6d-2a2c0ccd76f6.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DDEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DDEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

