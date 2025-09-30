module 0x3cb54e32d03d5648923f26b98d4e0ead6c6f69813e5ec3dd742c1a0118af2a71::capi {
    struct CAPI has drop {
        dummy_field: bool,
    }

    fun init(arg0: CAPI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CAPI>(arg0, 6, b"CAPI", b"CAPIBARA", b"Join the most relaxed community in crypto! $CAPI is your ticket to a fun, friendly, and chill blockchain experience. Collect, trade, and vibe with the capybara spirit.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreicxrxzhfrlh5tnp6xgkgrgumdututnr373hi64hmrefh3odexu6hq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CAPI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CAPI>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

