module 0x7d06f06cf8fed2256b4ff200d8ec2c81f0746c62768c73af364e2b8f39907a78::iend {
    struct IEND has drop {
        dummy_field: bool,
    }

    fun init(arg0: IEND, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IEND>(arg0, 9, b"IEND", b"ejnd", b"kdnd", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/463dbe81-4f6f-451b-8afb-9d54e967ddba.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IEND>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<IEND>>(v1);
    }

    // decompiled from Move bytecode v6
}

