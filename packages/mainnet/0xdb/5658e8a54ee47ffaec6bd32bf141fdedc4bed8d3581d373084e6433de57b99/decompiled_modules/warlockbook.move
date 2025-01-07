module 0xdb5658e8a54ee47ffaec6bd32bf141fdedc4bed8d3581d373084e6433de57b99::warlockbook {
    struct WARLOCKBOOK has drop {
        dummy_field: bool,
    }

    fun init(arg0: WARLOCKBOOK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WARLOCKBOOK>(arg0, 9, b"warlockbook", b"Warlock Book", b"WARLOCKBOOK IS OUT HERE RUNNING ON 1000% CAFFEINE AND SHEER LUNACY! WATCH YOUR PORTFOLIO WHIPLASH SO HARD YOULL THINK THE MATRIX IS GLITCHING. DOESNT CARE ABOUT YOUR SLEEP SCHEDULE.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cdna.artstation.com/p/assets/images/images/080/863/918/large/egor-ivanov-main.jpg?1728729381")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<WARLOCKBOOK>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WARLOCKBOOK>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WARLOCKBOOK>>(v1);
    }

    // decompiled from Move bytecode v6
}

