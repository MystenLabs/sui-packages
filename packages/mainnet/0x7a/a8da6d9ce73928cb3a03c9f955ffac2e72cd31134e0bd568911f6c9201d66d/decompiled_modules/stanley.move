module 0x7aa8da6d9ce73928cb3a03c9f955ffac2e72cd31134e0bd568911f6c9201d66d::stanley {
    struct STANLEY has drop {
        dummy_field: bool,
    }

    fun init(arg0: STANLEY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STANLEY>(arg0, 9, b"STANLEY", b"Stanley", b"STANLEY IS OUT HERE RUNNING ON 1000% CAFFEINE AND SHEER LUNACY! WATCH YOUR PORTFOLIO WHIPLASH SO HARD YOULL THINK THE MATRIX IS GLITCHING. DOESNT CARE ABOUT YOUR SLEEP SCHEDULE.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cdna.artstation.com/p/assets/images/images/080/757/624/large/paulo-gonzaga-stanley2.jpg?1728429170")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<STANLEY>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STANLEY>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STANLEY>>(v1);
    }

    // decompiled from Move bytecode v6
}

