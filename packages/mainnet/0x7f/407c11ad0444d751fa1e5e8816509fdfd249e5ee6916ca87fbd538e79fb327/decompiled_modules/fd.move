module 0x7f407c11ad0444d751fa1e5e8816509fdfd249e5ee6916ca87fbd538e79fb327::fd {
    struct FD has drop {
        dummy_field: bool,
    }

    fun init(arg0: FD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FD>(arg0, 9, b"FD", b"Dhrov ", b"Dhrov coin created by telegram ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/6e56416a-c9f8-4446-a0f0-4e66b1c5b413.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FD>>(v1);
    }

    // decompiled from Move bytecode v6
}

