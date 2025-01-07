module 0x322ffe756d444a95b8d85b78e391ee8db679c3a5dc6e7428bb2d4bb4d82b2d4d::synced {
    struct SYNCED has drop {
        dummy_field: bool,
    }

    fun init(arg0: SYNCED, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SYNCED>(arg0, 9, b"SYNCED", b"Synced", b"SYNCED IS OUT HERE RUNNING ON 1000% CAFFEINE AND SHEER LUNACY! WATCH YOUR PORTFOLIO WHIPLASH SO HARD YOULL THINK THE MATRIX IS GLITCHING. DOESNT CARE ABOUT YOUR SLEEP SCHEDULE.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cdna.artstation.com/p/assets/images/images/080/760/792/large/ranx-zz2.jpg?1728453554")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SYNCED>(&mut v2, 1000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SYNCED>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SYNCED>>(v1);
    }

    // decompiled from Move bytecode v6
}

