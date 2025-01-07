module 0x6dc3bb33a7b322b330282efc84aa1a4d71f0a3937c6bab0f1b4a27cbcc7da2c1::sonic {
    struct SONIC has drop {
        dummy_field: bool,
    }

    fun init(arg0: SONIC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SONIC>(arg0, 6, b"Sonic", b"SUINIC", b"Suinic is all about speed, energy, and fun. Inspired by the fast-paced world of Sonic and powered by the cutting-edge Sui blockchain, Suinic races ahead with lightning-fast transactions and a community-driven vision.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/2_AC_1_A076_E7_E4_443_D_B1_FB_9_AC_624_FE_5_F35_a36c21a16c.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SONIC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SONIC>>(v1);
    }

    // decompiled from Move bytecode v6
}

