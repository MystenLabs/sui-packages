module 0xbf5b9d3e957bb0c3bd47f8081bf321d1d753b17c1e8b985d46d372669f0905de::zed {
    struct ZED has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZED, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZED>(arg0, 9, b"ZED", b"Zed", b"ZED IS OUT HERE RUNNING ON 1000% CAFFEINE AND SHEER LUNACY! WATCH YOUR PORTFOLIO WHIPLASH SO HARD YOULL THINK THE MATRIX IS GLITCHING. DOESNT CARE ABOUT YOUR SLEEP SCHEDULE.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cdna.artstation.com/p/assets/images/images/080/478/894/large/emmanuel-luiz-rappit.jpg?1727701739")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<ZED>(&mut v2, 500000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZED>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ZED>>(v1);
    }

    // decompiled from Move bytecode v6
}

