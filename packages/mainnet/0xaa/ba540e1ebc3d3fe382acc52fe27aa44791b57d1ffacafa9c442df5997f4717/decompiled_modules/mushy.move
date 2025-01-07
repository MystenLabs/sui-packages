module 0xaaba540e1ebc3d3fe382acc52fe27aa44791b57d1ffacafa9c442df5997f4717::mushy {
    struct MUSHY has drop {
        dummy_field: bool,
    }

    fun init(arg0: MUSHY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MUSHY>(arg0, 9, b"MUSHY", b"Mushy", b"FUNNY", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/78qHnmVrJ3Yui813X1opHz1sw2zX8KnMr8ce2s6epump.png?size=lg&key=649181")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MUSHY>(&mut v2, 2000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MUSHY>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MUSHY>>(v1);
    }

    // decompiled from Move bytecode v6
}

