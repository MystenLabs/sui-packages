module 0xa84136bb06c1ddeb575627265feeb81482fa1a36a5dcd20fd932b5d5cf586aee::syrene {
    struct SYRENE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SYRENE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SYRENE>(arg0, 9, b"SYRENE", b"Syrene Skull Bed", b"SYRENE IS OUT HERE RUNNING ON 1000% CAFFEINE AND SHEER LUNACY! WATCH YOUR PORTFOLIO WHIPLASH SO HARD YOULL THINK THE MATRIX IS GLITCHING. DOESNT CARE ABOUT YOUR SLEEP SCHEDULE.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cdna.artstation.com/p/assets/images/images/080/231/080/large/paul-kwon-zeronis-img-8065.jpg?1727049177")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SYRENE>(&mut v2, 1000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SYRENE>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SYRENE>>(v1);
    }

    // decompiled from Move bytecode v6
}

