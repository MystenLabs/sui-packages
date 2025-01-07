module 0x8503425b0617686b8ca39ff1a671fba51478f4334a0c8863a25b6b45f5d282c6::tongsui {
    struct TONGSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TONGSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TONGSUI>(arg0, 9, b"tongsui", b"Tong Sui", b"TONGSUI IS OUT HERE RUNNING ON 1000% CAFFEINE AND SHEER LUNACY! WATCH YOUR PORTFOLIO WHIPLASH SO HARD YOULL THINK THE MATRIX IS GLITCHING. DOESNT CARE ABOUT YOUR SLEEP SCHEDULE.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cdn-icons-png.flaticon.com/512/890/890026.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TONGSUI>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TONGSUI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TONGSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

