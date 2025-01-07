module 0x1e08e399f207bb560ca1908c02f2d2e781e3ccba190e2d317eb489648c32cd51::vindicta {
    struct VINDICTA has drop {
        dummy_field: bool,
    }

    fun init(arg0: VINDICTA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VINDICTA>(arg0, 9, b"VINDICTA", b"Vindicta", b"VINDICTA IS OUT HERE RUNNING ON 1000% CAFFEINE AND SHEER LUNACY! WATCH YOUR PORTFOLIO WHIPLASH SO HARD YOULL THINK THE MATRIX IS GLITCHING. DOESNT CARE ABOUT YOUR SLEEP SCHEDULE.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cdna.artstation.com/p/assets/images/images/080/224/252/large/ino-moon-vindicta.jpg?1727029347")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<VINDICTA>(&mut v2, 1000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VINDICTA>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<VINDICTA>>(v1);
    }

    // decompiled from Move bytecode v6
}

