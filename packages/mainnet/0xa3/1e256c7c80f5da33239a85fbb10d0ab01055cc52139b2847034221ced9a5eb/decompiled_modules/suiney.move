module 0xa31e256c7c80f5da33239a85fbb10d0ab01055cc52139b2847034221ced9a5eb::suiney {
    struct SUINEY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUINEY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUINEY>(arg0, 9, b"suiney", b"Sydney Suiney", b"SBUBBLE IS OUT HERE RUNNING ON 1000% CAFFEINE AND SHEER LUNACY! WATCH YOUR PORTFOLIO WHIPLASH SO HARD YOULL THINK THE MATRIX IS GLITCHING. DOESNT CARE ABOUT YOUR SLEEP SCHEDULE.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://preview.redd.it/sydney-sweeney-for-dr-squatch-v0-0ppv9w17q6sd1.png?width=1080&crop=smart&auto=webp&s=65281ce7cca25420e9cc027b10e80ec729f1f5e2")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUINEY>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUINEY>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUINEY>>(v1);
    }

    // decompiled from Move bytecode v6
}

