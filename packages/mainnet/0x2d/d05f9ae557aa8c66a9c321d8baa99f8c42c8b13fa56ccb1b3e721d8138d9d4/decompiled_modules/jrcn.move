module 0x2dd05f9ae557aa8c66a9c321d8baa99f8c42c8b13fa56ccb1b3e721d8138d9d4::jrcn {
    struct JRCN has drop {
        dummy_field: bool,
    }

    fun init(arg0: JRCN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JRCN>(arg0, 6, b"JRCN", b"JOLLY RACCOON", b"Stealing trash and turning it into treasure. Jolly Raccoon is a bandit for gains.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/image_2024_12_19_044457787_b6c139ee89.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JRCN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JRCN>>(v1);
    }

    // decompiled from Move bytecode v6
}

