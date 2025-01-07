module 0xeb73a97aec222459cc12a614fe97bdb16814a78e507f5c087909b5b1eecf6bf8::dolimobono {
    struct DOLIMOBONO has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOLIMOBONO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOLIMOBONO>(arg0, 9, b"dolimobono", b"Dolimobono", b"DOLIMOBONO IS OUT HERE RUNNING ON 1000% CAFFEINE AND SHEER LUNACY! WATCH YOUR PORTFOLIO WHIPLASH SO HARD YOULL THINK THE MATRIX IS GLITCHING. DOESNT CARE ABOUT YOUR SLEEP SCHEDULE.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cdna.artstation.com/p/assets/images/images/080/666/158/large/huan-gugu-zcvcx-fullquality.jpg?1728203166")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<DOLIMOBONO>(&mut v2, 5000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOLIMOBONO>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOLIMOBONO>>(v1);
    }

    // decompiled from Move bytecode v6
}

