module 0xbfc07f7a1454aacb4eb353a1ad20fa79090d7c8838332349ee6e312caeacd917::fimgo {
    struct FIMGO has drop {
        dummy_field: bool,
    }

    fun init(arg0: FIMGO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FIMGO>(arg0, 9, b"FIMGO", b"Sword Ghost Fimgo", b"FIMGO IS OUT HERE RUNNING ON 1000% CAFFEINE AND SHEER LUNACY! WATCH YOUR PORTFOLIO WHIPLASH SO HARD YOULL THINK THE MATRIX IS GLITCHING. DOESNT CARE ABOUT YOUR SLEEP SCHEDULE.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cdna.artstation.com/p/assets/images/images/078/291/146/large/keny-bigny-samurairender1.jpg?1721724513")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<FIMGO>(&mut v2, 500000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FIMGO>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FIMGO>>(v1);
    }

    // decompiled from Move bytecode v6
}

