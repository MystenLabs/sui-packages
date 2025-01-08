module 0xd8610e7a790ede57e766fa384c6a63473a0fab47cf3b5b818d3cd910c19a295::catai {
    struct CATAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATAI>(arg0, 6, b"CATAI", b"LickCatAI", b"LickCatAI is the newest form of AI implementing the ferocious lick of the Void Cat, with it you can generate any amount of licks you can imagine it will change your life once you start using it", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/cat_kitty_cute_lick_black_cat_13bfe36c2e.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CATAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

