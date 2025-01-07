module 0x698754aa2937270e15453ce1572c986ad82dccd3820ca73a3569651fb4d9e723::shaman {
    struct SHAMAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHAMAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHAMAN>(arg0, 9, b"SHAMAN", b"Shaman", b"SHAMAN IS OUT HERE RUNNING ON 1000% CAFFEINE AND SHEER LUNACY! WATCH YOUR PORTFOLIO WHIPLASH SO HARD YOULL THINK THE MATRIX IS GLITCHING. DOESNT CARE ABOUT YOUR SLEEP SCHEDULE.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cdnb.artstation.com/p/assets/images/images/080/828/099/large/liu-xing-qiuzhang-lv-3-0000.jpg?1728612657")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SHAMAN>(&mut v2, 10000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHAMAN>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHAMAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

