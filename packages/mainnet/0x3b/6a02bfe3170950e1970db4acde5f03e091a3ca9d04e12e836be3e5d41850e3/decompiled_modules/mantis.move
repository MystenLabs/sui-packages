module 0x3b6a02bfe3170950e1970db4acde5f03e091a3ca9d04e12e836be3e5d41850e3::mantis {
    struct MANTIS has drop {
        dummy_field: bool,
    }

    fun init(arg0: MANTIS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MANTIS>(arg0, 9, b"MANTIS", b"Armed Mantis", b"MANTIS IS OUT HERE RUNNING ON 1000% CAFFEINE AND SHEER LUNACY! WATCH YOUR PORTFOLIO WHIPLASH SO HARD YOULL THINK THE MATRIX IS GLITCHING. DOESNT CARE ABOUT YOUR SLEEP SCHEDULE.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cdnb.artstation.com/p/assets/images/images/080/665/513/large/huan-gugu-jjkk-fullquality.jpg?1728200831")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MANTIS>(&mut v2, 10000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MANTIS>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MANTIS>>(v1);
    }

    // decompiled from Move bytecode v6
}

