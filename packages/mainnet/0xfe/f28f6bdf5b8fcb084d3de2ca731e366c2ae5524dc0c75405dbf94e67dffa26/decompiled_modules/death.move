module 0xfef28f6bdf5b8fcb084d3de2ca731e366c2ae5524dc0c75405dbf94e67dffa26::death {
    struct DEATH has drop {
        dummy_field: bool,
    }

    fun init(arg0: DEATH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DEATH>(arg0, 9, b"DEATH", b"Death Throws", b"DEATH IS OUT HERE RUNNING ON 1000% CAFFEINE AND SHEER LUNACY! WATCH YOUR PORTFOLIO WHIPLASH SO HARD YOULL THINK THE MATRIX IS GLITCHING. DOESNT CARE ABOUT YOUR SLEEP SCHEDULE.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cdn.dribbble.com/userupload/14051186/file/original-a607bfe03813e04883221917dc420078.png?resize=1024x768")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<DEATH>(&mut v2, 10000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DEATH>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DEATH>>(v1);
    }

    // decompiled from Move bytecode v6
}

