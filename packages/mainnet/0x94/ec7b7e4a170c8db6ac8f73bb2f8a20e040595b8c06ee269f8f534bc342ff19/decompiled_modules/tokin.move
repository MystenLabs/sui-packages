module 0x94ec7b7e4a170c8db6ac8f73bb2f8a20e040595b8c06ee269f8f534bc342ff19::tokin {
    struct TOKIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOKIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOKIN>(arg0, 6, b"Tokin", b"Token Insight", b"Find Gems, Share Gems, Support hidden Gems to bluechip tokens. All in @Suinetwork", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_ede08f41da.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOKIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TOKIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

