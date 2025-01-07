module 0x4b93d0e4faab524c9708cfacda60906178145c3684b54cc7f16c5b0d73e33c9a::suidogg {
    struct SUIDOGG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIDOGG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIDOGG>(arg0, 6, b"SuiDOgg", b"Sui Dogg", b"La Di Da De We like to party! Come get some of the best dogg on sui nephew ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/SUI_DOGG_1d94373a75.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIDOGG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIDOGG>>(v1);
    }

    // decompiled from Move bytecode v6
}

