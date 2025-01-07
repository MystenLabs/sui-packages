module 0x79e19129257eca71148538a707aadfda6ad4daeceebaaba6ea1e5b6a572e4e0a::lucy {
    struct LUCY has drop {
        dummy_field: bool,
    }

    fun init(arg0: LUCY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LUCY>(arg0, 9, b"LUCY", b"Lucy", b"LUCY IS OUT HERE RUNNING ON 1000% CAFFEINE AND SHEER LUNACY! WATCH YOUR PORTFOLIO WHIPLASH SO HARD YOULL THINK THE MATRIX IS GLITCHING. DOESNT CARE ABOUT YOUR SLEEP SCHEDULE.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cdnb.artstation.com/p/assets/images/images/080/703/511/large/-r02.jpg?1728307232")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<LUCY>(&mut v2, 10000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LUCY>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LUCY>>(v1);
    }

    // decompiled from Move bytecode v6
}

