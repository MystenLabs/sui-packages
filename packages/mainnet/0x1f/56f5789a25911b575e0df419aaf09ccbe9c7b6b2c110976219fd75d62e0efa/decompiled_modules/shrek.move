module 0x1f56f5789a25911b575e0df419aaf09ccbe9c7b6b2c110976219fd75d62e0efa::shrek {
    struct SHREK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHREK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHREK>(arg0, 6, b"SHREK", b"Shrek", b"Introducing $SHREK, the swampiest token on the Sui blockchain! After years of living off the grid in his swamp, Shrek has finally decided to go digital.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/shrek_fer_dcfa3b26e8.PNG")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHREK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHREK>>(v1);
    }

    // decompiled from Move bytecode v6
}

