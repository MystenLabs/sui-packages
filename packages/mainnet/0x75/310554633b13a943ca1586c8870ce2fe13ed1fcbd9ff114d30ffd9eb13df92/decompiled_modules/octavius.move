module 0x75310554633b13a943ca1586c8870ce2fe13ed1fcbd9ff114d30ffd9eb13df92::octavius {
    struct OCTAVIUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: OCTAVIUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OCTAVIUS>(arg0, 9, b"OCTAVIUS", b"Doctor Otto Octavius", b"OCTAVIUS IS OUT HERE RUNNING ON 1000% CAFFEINE AND SHEER LUNACY! WATCH YOUR PORTFOLIO WHIPLASH SO HARD YOULL THINK THE MATRIX IS GLITCHING. DOESNT CARE ABOUT YOUR SLEEP SCHEDULE.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cdna.artstation.com/p/assets/images/images/080/887/810/large/paul-deasy-dock-ock-hex.jpg?1728819815")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<OCTAVIUS>(&mut v2, 100000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OCTAVIUS>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OCTAVIUS>>(v1);
    }

    // decompiled from Move bytecode v6
}

