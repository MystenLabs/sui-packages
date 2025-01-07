module 0xb76f9006cf1422e8f4cefa456611199d80e80b65c0701799f7f4e65ac62910af::alberic {
    struct ALBERIC has drop {
        dummy_field: bool,
    }

    fun init(arg0: ALBERIC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ALBERIC>(arg0, 9, b"alberic", b"Alberic Cat", b"ALBERIC IS OUT HERE RUNNING ON 1000% CAFFEINE AND SHEER LUNACY! WATCH YOUR PORTFOLIO WHIPLASH SO HARD YOULL THINK THE MATRIX IS GLITCHING. DOESNT CARE ABOUT YOUR SLEEP SCHEDULE.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cdna.artstation.com/p/assets/images/images/080/707/168/large/tatiana-pavlova-aka-doriana-dream-alberic-illustration-for-web-close-up.jpg?1728313492")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<ALBERIC>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ALBERIC>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ALBERIC>>(v1);
    }

    // decompiled from Move bytecode v6
}

