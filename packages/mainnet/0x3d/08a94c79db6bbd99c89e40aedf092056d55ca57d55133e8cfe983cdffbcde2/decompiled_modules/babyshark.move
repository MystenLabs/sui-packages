module 0x3d08a94c79db6bbd99c89e40aedf092056d55ca57d55133e8cfe983cdffbcde2::babyshark {
    struct BABYSHARK has drop {
        dummy_field: bool,
    }

    fun init(arg0: BABYSHARK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BABYSHARK>(arg0, 9, b"BABYSHARK", b"Baby Shark Tu Ru Ru Ru Ru", b"BABYSHARK IS OUT HERE RUNNING ON 1000% CAFFEINE AND SHEER LUNACY! WATCH YOUR PORTFOLIO WHIPLASH SO HARD YOULL THINK THE MATRIX IS GLITCHING. DOESNT CARE ABOUT YOUR SLEEP SCHEDULE.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cdna.artstation.com/p/assets/images/images/080/763/614/large/rock-d-20241008194332.jpg?1728452263")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BABYSHARK>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BABYSHARK>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BABYSHARK>>(v1);
    }

    // decompiled from Move bytecode v6
}

