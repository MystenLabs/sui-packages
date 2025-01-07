module 0x51b35615d260679a50c3df19091bea1267d5f374bfdf38e36d26802c2dbb5e5e::zyn {
    struct ZYN has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZYN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZYN>(arg0, 9, b"ZYN", b"Zyn Token (6B mcap soon)", b"ZYN IS OUT HERE RUNNING ON 1000% CAFFEINE AND SHEER LUNACY! WATCH YOUR PORTFOLIO WHIPLASH SO HARD YOULL THINK THE MATRIX IS GLITCHING. DOESNT CARE ABOUT YOUR SLEEP SCHEDULE.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://movepump.com/_next/image?url=https%3A%2F%2Fapi.movepump.com%2Fuploads%2FIMG_2120_f07e52f09b.jpeg&w=256&q=75")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<ZYN>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZYN>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ZYN>>(v1);
    }

    // decompiled from Move bytecode v6
}

