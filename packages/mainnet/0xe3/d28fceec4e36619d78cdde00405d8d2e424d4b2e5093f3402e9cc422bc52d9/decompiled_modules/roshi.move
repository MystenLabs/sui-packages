module 0xe3d28fceec4e36619d78cdde00405d8d2e424d4b2e5093f3402e9cc422bc52d9::roshi {
    struct ROSHI has drop {
        dummy_field: bool,
    }

    fun init(arg0: ROSHI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ROSHI>(arg0, 9, b"ROSHI", b"Master Roshi", b"ROSHI IS OUT HERE RUNNING ON 1000% CAFFEINE AND SHEER LUNACY! WATCH YOUR PORTFOLIO WHIPLASH SO HARD YOULL THINK THE MATRIX IS GLITCHING. DOESNT CARE ABOUT YOUR SLEEP SCHEDULE.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cdna.artstation.com/p/assets/images/images/079/814/334/large/xai-tbrender001-viewport.jpg?1725899994")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<ROSHI>(&mut v2, 3000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ROSHI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ROSHI>>(v1);
    }

    // decompiled from Move bytecode v6
}

