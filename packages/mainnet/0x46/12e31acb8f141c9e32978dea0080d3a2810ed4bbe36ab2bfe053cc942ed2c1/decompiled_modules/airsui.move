module 0x4612e31acb8f141c9e32978dea0080d3a2810ed4bbe36ab2bfe053cc942ed2c1::airsui {
    struct AIRSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: AIRSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AIRSUI>(arg0, 6, b"AIRSUI", b"SUI Airdrop", b"Blessings from the sky !", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suidrop_ea7b09d790.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AIRSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AIRSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

