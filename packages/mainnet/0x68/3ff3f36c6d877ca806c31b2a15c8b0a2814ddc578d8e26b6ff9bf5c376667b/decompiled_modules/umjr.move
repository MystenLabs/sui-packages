module 0x683ff3f36c6d877ca806c31b2a15c8b0a2814ddc578d8e26b6ff9bf5c376667b::umjr {
    struct UMJR has drop {
        dummy_field: bool,
    }

    fun init(arg0: UMJR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UMJR>(arg0, 9, b"UMJR", b"URSAMAJOR", b"FORGET THE MAJOR! RHIS IS URSA MAJOR HERE!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/0077560f-e2a5-4480-bcc1-501106a7c0a4.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UMJR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<UMJR>>(v1);
    }

    // decompiled from Move bytecode v6
}

