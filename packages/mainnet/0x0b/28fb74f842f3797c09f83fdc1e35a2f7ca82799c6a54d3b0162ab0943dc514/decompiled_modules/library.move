module 0xb28fb74f842f3797c09f83fdc1e35a2f7ca82799c6a54d3b0162ab0943dc514::library {
    struct LIBRARY has drop {
        dummy_field: bool,
    }

    fun init(arg0: LIBRARY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LIBRARY>(arg0, 9, b"LIBRARY", b"Library Token WTF?", b"LIBRARY IS OUT HERE RUNNING ON 1000% CAFFEINE AND SHEER LUNACY! WATCH YOUR PORTFOLIO WHIPLASH SO HARD YOULL THINK THE MATRIX IS GLITCHING. DOESNT CARE ABOUT YOUR SLEEP SCHEDULE.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cdna.artstation.com/p/assets/images/images/080/479/212/large/sophie-almecija-almecija-sophie-a.jpg?1727702187")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<LIBRARY>(&mut v2, 10000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LIBRARY>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LIBRARY>>(v1);
    }

    // decompiled from Move bytecode v6
}

