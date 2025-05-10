module 0x9e9e2b18e37ed9a426ec813f90d3b2132d649b9809487075a1c85aef8b83c49a::charm {
    struct CHARM has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHARM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHARM>(arg0, 6, b"CHARM", b"CHARMANDERSUI", b"CharmSui is a fire-charged cryptocurrency on the SUI blockchain, sparking innovation and electrifying the crypto world", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreidjfxk6cwmdzeohfygq6mjbykz7kpfo57kqtty2h2kpsfoxjkj5pe")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHARM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CHARM>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

