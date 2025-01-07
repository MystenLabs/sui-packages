module 0xdae86aa049d025a76e74ddd7e90a59516479665dce0c16b2ce6fe08e28289e7a::pirat {
    struct PIRAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIRAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PIRAT>(arg0, 6, b"PIRAT", b"pirat", b"bhhhgvghgvb", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/pirate_meme_1507576581.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PIRAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PIRAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

