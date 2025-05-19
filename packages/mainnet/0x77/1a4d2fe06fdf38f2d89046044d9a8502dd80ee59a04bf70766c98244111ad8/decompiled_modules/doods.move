module 0x771a4d2fe06fdf38f2d89046044d9a8502dd80ee59a04bf70766c98244111ad8::doods {
    struct DOODS has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOODS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOODS>(arg0, 6, b"Doods", b"Doodles", b"Doodles are fun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreifxxsx7zdmwwau7kgdzu5qywe5xenxtkbrw5ynhccnhym2ews5v6i")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOODS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DOODS>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

