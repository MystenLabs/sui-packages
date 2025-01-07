module 0x372ee4a5512412c8eebc11a3a16561dcedeb70e650eb557ec524dd13c84ba6da::sajack {
    struct SAJACK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAJACK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SAJACK>(arg0, 9, b"SAJACK", b"Samurai Jack", b"SAJACK IS OUT HERE RUNNING ON 1000% CAFFEINE AND SHEER LUNACY! WATCH YOUR PORTFOLIO WHIPLASH SO HARD YOULL THINK THE MATRIX IS GLITCHING. DOESNT CARE ABOUT YOUR SLEEP SCHEDULE.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cdna.artstation.com/p/assets/images/images/080/813/196/large/umral-ismayilov-main.jpg?1728573428")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SAJACK>(&mut v2, 10000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAJACK>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SAJACK>>(v1);
    }

    // decompiled from Move bytecode v6
}

