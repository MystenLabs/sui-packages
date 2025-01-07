module 0xb6bec850d4a6bfeb4054d5485afe553e8a88f50568493a383852bfc2ce9d31e3::suidogg {
    struct SUIDOGG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIDOGG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIDOGG>(arg0, 6, b"SUIDOGG", b"Sui Dogg", b"La di da de it's time to party! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000020958_db45f4fa3f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIDOGG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIDOGG>>(v1);
    }

    // decompiled from Move bytecode v6
}

