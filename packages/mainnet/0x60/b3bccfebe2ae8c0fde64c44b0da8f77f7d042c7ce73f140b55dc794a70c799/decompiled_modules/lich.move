module 0x60b3bccfebe2ae8c0fde64c44b0da8f77f7d042c7ce73f140b55dc794a70c799::lich {
    struct LICH has drop {
        dummy_field: bool,
    }

    fun init(arg0: LICH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LICH>(arg0, 9, b"LICH", b"Lich", b"LICH IS OUT HERE RUNNING ON 1000% CAFFEINE AND SHEER LUNACY! WATCH YOUR PORTFOLIO WHIPLASH SO HARD YOULL THINK THE MATRIX IS GLITCHING. DOESNT CARE ABOUT YOUR SLEEP SCHEDULE.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cdnb.artstation.com/p/assets/images/images/080/707/949/large/pedro-chelles-lich-postar-2.jpg?1728314761")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<LICH>(&mut v2, 5000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LICH>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LICH>>(v1);
    }

    // decompiled from Move bytecode v6
}

