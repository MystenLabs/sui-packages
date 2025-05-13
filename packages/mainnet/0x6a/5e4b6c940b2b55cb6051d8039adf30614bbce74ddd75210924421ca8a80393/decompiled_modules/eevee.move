module 0x6a5e4b6c940b2b55cb6051d8039adf30614bbce74ddd75210924421ca8a80393::eevee {
    struct EEVEE has drop {
        dummy_field: bool,
    }

    fun init(arg0: EEVEE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EEVEE>(arg0, 9, b"EEVEE", b"Eevee", b"$EEVEE- Memes evolve. So do we. https://x.com/Eeveesui https://www.eevve.xyz", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreicr4iu66hr66cza4qzpq4ntewafjw3nx3xk3cwbuiyws6ma2amm74")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<EEVEE>(&mut v2, 1000000000000000000, @0xc5d34729571e41dec7272e8b26e85290b576953d453c58728ef1203f9bb2e527, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EEVEE>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<EEVEE>>(v1);
    }

    // decompiled from Move bytecode v6
}

