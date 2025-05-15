module 0xc1f59db3e6b7ab0617abf376e84f52286aad1d6cf3b881cb5167c632cba8d79e::pokeboob {
    struct POKEBOOB has drop {
        dummy_field: bool,
    }

    fun init(arg0: POKEBOOB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POKEBOOB>(arg0, 6, b"Pokeboob", b"Pokeboobs", b"First boobs ( Poke) on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiaotc4lnb3lbdmk6chcp6awignht4j6hrzeejhn4bbgl354mr6kw4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POKEBOOB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<POKEBOOB>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

