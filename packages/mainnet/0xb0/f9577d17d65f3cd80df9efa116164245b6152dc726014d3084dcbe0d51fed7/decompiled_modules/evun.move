module 0xb0f9577d17d65f3cd80df9efa116164245b6152dc726014d3084dcbe0d51fed7::evun {
    struct EVUN has drop {
        dummy_field: bool,
    }

    fun init(arg0: EVUN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EVUN>(arg0, 6, b"EVUN", b"EVUN CHUNG", b"Evun Chung is the almighti leeder of da SUI netwurk. Dex to be paid immediately - big things coming!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_09_19_095954_5294d10931.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EVUN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<EVUN>>(v1);
    }

    // decompiled from Move bytecode v6
}

