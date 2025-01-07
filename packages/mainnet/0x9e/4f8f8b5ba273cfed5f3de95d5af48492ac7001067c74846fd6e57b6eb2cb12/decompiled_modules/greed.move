module 0x9e4f8f8b5ba273cfed5f3de95d5af48492ac7001067c74846fd6e57b6eb2cb12::greed {
    struct GREED has drop {
        dummy_field: bool,
    }

    fun init(arg0: GREED, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GREED>(arg0, 9, b"GREED", b"Greed", b"GREED IS OUT HERE RUNNING ON 1000% CAFFEINE AND SHEER LUNACY! WATCH YOUR PORTFOLIO WHIPLASH SO HARD YOULL THINK THE MATRIX IS GLITCHING. DOESNT CARE ABOUT YOUR SLEEP SCHEDULE.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cdnb.artstation.com/p/assets/images/images/080/517/635/large/pablo-hurtado-de-mendoza-27122023.jpg?1727790937")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<GREED>(&mut v2, 10000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GREED>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GREED>>(v1);
    }

    // decompiled from Move bytecode v6
}

