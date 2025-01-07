module 0x74251173b6716b11e672c2d7610af8ab4da587d154d4c8ed366628601c2811b6::tyranitar {
    struct TYRANITAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: TYRANITAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TYRANITAR>(arg0, 9, b"TYRANITAR", b"Tyranitar", b"TYRANITAR IS OUT HERE RUNNING ON 1000% CAFFEINE AND SHEER LUNACY! WATCH YOUR PORTFOLIO WHIPLASH SO HARD YOULL THINK THE MATRIX IS GLITCHING. DOESNT CARE ABOUT YOUR SLEEP SCHEDULE.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cdnb.artstation.com/p/assets/images/images/078/485/929/large/jose-de-las-heras-mainshot-tyra-artstation-png.jpg?1722255886")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TYRANITAR>(&mut v2, 3000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TYRANITAR>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TYRANITAR>>(v1);
    }

    // decompiled from Move bytecode v6
}

