module 0x94abf3c4c3a18b2a5362aa78a3df225a4f4e7042e196c6f03e1e5ad31c9a14d5::demonic {
    struct DEMONIC has drop {
        dummy_field: bool,
    }

    fun init(arg0: DEMONIC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DEMONIC>(arg0, 9, b"DEMONIC", b"Twill Demonic Moth", b"DEMONIC IS OUT HERE RUNNING ON 1000% CAFFEINE AND SHEER LUNACY! WATCH YOUR PORTFOLIO WHIPLASH SO HARD YOULL THINK THE MATRIX IS GLITCHING. DOESNT CARE ABOUT YOUR SLEEP SCHEDULE.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cdna.artstation.com/p/assets/images/images/053/186/630/large/stasia-bubnova-screenshot004.jpg?1661623016")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<DEMONIC>(&mut v2, 10000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DEMONIC>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DEMONIC>>(v1);
    }

    // decompiled from Move bytecode v6
}

