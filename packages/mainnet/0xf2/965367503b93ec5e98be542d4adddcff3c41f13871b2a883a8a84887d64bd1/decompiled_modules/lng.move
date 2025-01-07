module 0xf2965367503b93ec5e98be542d4adddcff3c41f13871b2a883a8a84887d64bd1::lng {
    struct LNG has drop {
        dummy_field: bool,
    }

    fun init(arg0: LNG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LNG>(arg0, 9, b"LNG", b"LONG", b"LONG Token is a unique cryptocurrency designed for long-term investment and wealth accumulation. With a focus on security and scalability, it aims to empower users to grow their assets steadily over time. Join the future of finance with LONG!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d5e07bb9-c0ef-4faa-bc53-2e70b63d55a6.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LNG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LNG>>(v1);
    }

    // decompiled from Move bytecode v6
}

