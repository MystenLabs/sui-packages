module 0xb3bf199a930400fb73ab95ef64a38b176ffcafdb8428c3e0b9e58aecbf3eb05c::bowsui {
    struct BOWSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOWSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOWSUI>(arg0, 6, b"BOWSUI", b"BRETT OF WILD SUI", b" Brett entering the wild of SUI network, engaging on new terrain and new battles.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_12_01_24_49_5f79400f3f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOWSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOWSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

