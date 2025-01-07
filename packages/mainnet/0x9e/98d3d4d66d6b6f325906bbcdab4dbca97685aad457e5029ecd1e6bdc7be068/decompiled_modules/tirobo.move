module 0x9e98d3d4d66d6b6f325906bbcdab4dbca97685aad457e5029ecd1e6bdc7be068::tirobo {
    struct TIROBO has drop {
        dummy_field: bool,
    }

    fun init(arg0: TIROBO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TIROBO>(arg0, 9, b"TIROBO", b"The King of", b"TIROBO IS OUT HERE RUNNING ON 1000% CAFFEINE AND SHEER LUNACY! WATCH YOUR PORTFOLIO WHIPLASH SO HARD YOULL THINK THE MATRIX IS GLITCHING. DOESNT CARE ABOUT YOUR SLEEP SCHEDULE.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cdnb.artstation.com/p/assets/images/images/080/111/623/large/rock-d-pangzai.jpg?1726702521")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TIROBO>(&mut v2, 300000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TIROBO>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TIROBO>>(v1);
    }

    // decompiled from Move bytecode v6
}

