module 0xece432d33dfc5944319e38cc783fdc706a81250158859c183c77c12deb2be493::oink {
    struct OINK has drop {
        dummy_field: bool,
    }

    fun init(arg0: OINK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OINK>(arg0, 6, b"OINK", b"TurbosOink", b"Oink, the long-lost twin brother of Waddles from the movie \"Gravity Falls\", had a fate quite different from his famous sibling. While Waddles was adopted by Mabel and lived a peaceful life, Oink accidentally got swept into a different timeline when a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730992564648.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OINK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OINK>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

