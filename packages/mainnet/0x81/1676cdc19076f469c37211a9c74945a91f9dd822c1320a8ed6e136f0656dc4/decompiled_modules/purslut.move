module 0x811676cdc19076f469c37211a9c74945a91f9dd822c1320a8ed6e136f0656dc4::purslut {
    struct PURSLUT has drop {
        dummy_field: bool,
    }

    fun init(arg0: PURSLUT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PURSLUT>(arg0, 9, b"PURSLUT", b"Sui Purple Slut", b"PURSLUT IS OUT HERE RUNNING ON 1000% CAFFEINE AND SHEER LUNACY! WATCH YOUR PORTFOLIO WHIPLASH SO HARD YOULL THINK THE MATRIX IS GLITCHING. DOESNT CARE ABOUT YOUR SLEEP SCHEDULE.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cdnb.artstation.com/p/assets/images/images/080/836/975/large/vlx-novikov-screenshot-24.jpg?1728643935")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PURSLUT>(&mut v2, 10000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PURSLUT>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PURSLUT>>(v1);
    }

    // decompiled from Move bytecode v6
}

