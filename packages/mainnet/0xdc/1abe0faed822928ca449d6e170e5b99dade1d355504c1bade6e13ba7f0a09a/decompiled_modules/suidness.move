module 0xdc1abe0faed822928ca449d6e170e5b99dade1d355504c1bade6e13ba7f0a09a::suidness {
    struct SUIDNESS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIDNESS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIDNESS>(arg0, 6, b"SUIDNESS", b"SUIDNESS ON SUI", b"$SUIDNESS brings a refreshing change of pace. Inspired by Sadness from Inside Out and powered by the innovative SUI Network, $SUIDNESS delivers a simple yet profound message: even in the lows, there is value,  $SUIDNESS -  Where even sadness finds its place on the blockchain.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/8_ede55423e4.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIDNESS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIDNESS>>(v1);
    }

    // decompiled from Move bytecode v6
}

