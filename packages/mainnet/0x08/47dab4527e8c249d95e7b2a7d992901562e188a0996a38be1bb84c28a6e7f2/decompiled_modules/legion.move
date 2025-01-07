module 0x847dab4527e8c249d95e7b2a7d992901562e188a0996a38be1bb84c28a6e7f2::legion {
    struct LEGION has drop {
        dummy_field: bool,
    }

    fun init(arg0: LEGION, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LEGION>(arg0, 9, b"LEGION", b"Fomo Legion", b"LEGION IS OUT HERE RUNNING ON 1000% CAFFEINE AND SHEER LUNACY! WATCH YOUR PORTFOLIO WHIPLASH SO HARD YOULL THINK THE MATRIX IS GLITCHING. DOESNT CARE ABOUT YOUR SLEEP SCHEDULE.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cdna.artstation.com/p/assets/images/images/080/791/834/large/john-a-carbon-legionz-camera-4-002.jpg?1728514743")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<LEGION>(&mut v2, 1000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LEGION>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LEGION>>(v1);
    }

    // decompiled from Move bytecode v6
}

