module 0x27b640f2f8f5afc2828b81c739e12561befc5425d45899716142896a2f415c57::rhino {
    struct RHINO has drop {
        dummy_field: bool,
    }

    fun init(arg0: RHINO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RHINO>(arg0, 9, b"RHINO", b"Rhino", b"RHINO IS OUT HERE RUNNING ON 1000% CAFFEINE AND SHEER LUNACY! WATCH YOUR PORTFOLIO WHIPLASH SO HARD YOULL THINK THE MATRIX IS GLITCHING. DOESNT CARE ABOUT YOUR SLEEP SCHEDULE.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cdnb.artstation.com/p/assets/images/images/080/832/665/large/miguel-gutierrez-render-main-camera-0-fullquality-004.jpg?1728633199")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<RHINO>(&mut v2, 1000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RHINO>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RHINO>>(v1);
    }

    // decompiled from Move bytecode v6
}

