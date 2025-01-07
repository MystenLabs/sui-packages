module 0x83c769ee1a3f05bd666d4bf28ede0ab734477458aa0b1e51c702608ac1e5e8c7::sofia {
    struct SOFIA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOFIA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SOFIA>(arg0, 9, b"SOFIA", b"Sofia", b"SOFIA IS OUT HERE RUNNING ON 1000% CAFFEINE AND SHEER LUNACY! WATCH YOUR PORTFOLIO WHIPLASH SO HARD YOULL THINK THE MATRIX IS GLITCHING. DOESNT CARE ABOUT YOUR SLEEP SCHEDULE.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cdnb.artstation.com/p/assets/images/images/080/862/417/large/798_-shuhang-li-04.jpg?1728723979")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SOFIA>(&mut v2, 10000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOFIA>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SOFIA>>(v1);
    }

    // decompiled from Move bytecode v6
}

