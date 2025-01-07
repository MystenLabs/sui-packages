module 0xf6020cb216e5095a70dddda55e425a120c81b8c6260d3ec013f805ef63781481::steeple {
    struct STEEPLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: STEEPLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STEEPLE>(arg0, 9, b"STEEPLE", b"Helphen's Steeple", b"STEEPLE IS OUT HERE RUNNING ON 1000% CAFFEINE AND SHEER LUNACY! WATCH YOUR PORTFOLIO WHIPLASH SO HARD YOULL THINK THE MATRIX IS GLITCHING. DOESNT CARE ABOUT YOUR SLEEP SCHEDULE.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cdna.artstation.com/p/assets/images/images/080/802/700/large/yuri-chuchmay-2024-helphens-steeple.jpg?1728552945")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<STEEPLE>(&mut v2, 10000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STEEPLE>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STEEPLE>>(v1);
    }

    // decompiled from Move bytecode v6
}

