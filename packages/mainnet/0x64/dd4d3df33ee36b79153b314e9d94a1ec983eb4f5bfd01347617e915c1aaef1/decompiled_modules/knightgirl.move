module 0x64dd4d3df33ee36b79153b314e9d94a1ec983eb4f5bfd01347617e915c1aaef1::knightgirl {
    struct KNIGHTGIRL has drop {
        dummy_field: bool,
    }

    fun init(arg0: KNIGHTGIRL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KNIGHTGIRL>(arg0, 9, b"knightgirl", b"Knight Girl", b"KNIGHTGIRL IS OUT HERE RUNNING ON 1000% CAFFEINE AND SHEER LUNACY! WATCH YOUR PORTFOLIO WHIPLASH SO HARD YOULL THINK THE MATRIX IS GLITCHING. DOESNT CARE ABOUT YOUR SLEEP SCHEDULE.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cdna.artstation.com/p/assets/images/images/080/794/360/large/baekorang2-last.jpg?1728523885")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<KNIGHTGIRL>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KNIGHTGIRL>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KNIGHTGIRL>>(v1);
    }

    // decompiled from Move bytecode v6
}

