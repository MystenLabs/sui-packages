module 0x3545b10b4becda95d0c9ef6e05dda8475ed6bd455026c9765861a1c1ec5e05a4::larry {
    struct LARRY has drop {
        dummy_field: bool,
    }

    fun init(arg0: LARRY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LARRY>(arg0, 6, b"LARRY", b"OG TWITTER MASCOT", x"44696420796f7520616c6c206b6e6f77205477697474657227732069636f6e69632062697264206c6f676f2061637475616c6c79206861732061206e616d653f20f09f90a620497427732063616c6c656420274c6172727927206166746572204e4241206c6567656e64204c617272792042697264212054686973206c6974746c652d6b6e6f776e206661637420676976657320612066756e20747769737420746f20746865206c6f676f20776520736565206576657279206461792e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731829426959.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LARRY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LARRY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

