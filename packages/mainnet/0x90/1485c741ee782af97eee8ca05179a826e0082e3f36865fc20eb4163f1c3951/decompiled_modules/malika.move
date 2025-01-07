module 0x901485c741ee782af97eee8ca05179a826e0082e3f36865fc20eb4163f1c3951::malika {
    struct MALIKA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MALIKA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MALIKA>(arg0, 9, b"MALIKA", b"Malika", b"MALIKA IS OUT HERE RUNNING ON 1000% CAFFEINE AND SHEER LUNACY! WATCH YOUR PORTFOLIO WHIPLASH SO HARD YOULL THINK THE MATRIX IS GLITCHING. DOESNT CARE ABOUT YOUR SLEEP SCHEDULE.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cdnb.artstation.com/p/assets/images/images/076/939/201/large/hiroaki-nakanishi-85582f18-6615-4f70-ba3a-55835ec4e20b.jpg?1718182426")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MALIKA>(&mut v2, 30000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MALIKA>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MALIKA>>(v1);
    }

    // decompiled from Move bytecode v6
}

