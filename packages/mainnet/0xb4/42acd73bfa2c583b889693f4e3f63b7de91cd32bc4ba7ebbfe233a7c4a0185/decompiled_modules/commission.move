module 0xb442acd73bfa2c583b889693f4e3f63b7de91cd32bc4ba7ebbfe233a7c4a0185::commission {
    struct COMMISSION has drop {
        dummy_field: bool,
    }

    fun init(arg0: COMMISSION, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COMMISSION>(arg0, 9, b"commission", b"Commission", b"COMMISSION IS OUT HERE RUNNING ON 1000% CAFFEINE AND SHEER LUNACY! WATCH YOUR PORTFOLIO WHIPLASH SO HARD YOULL THINK THE MATRIX IS GLITCHING. DOESNT CARE ABOUT YOUR SLEEP SCHEDULE.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cdnb.artstation.com/p/assets/images/images/080/775/057/large/helena-nikulina-commission-54.jpg?1728480628")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<COMMISSION>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COMMISSION>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<COMMISSION>>(v1);
    }

    // decompiled from Move bytecode v6
}

