module 0x51582e64866b993b8dfc55121f20ca8623fc8dabc4cd9117abc83dda152f7976::sol {
    struct SOL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SOL>(arg0, 6, b"SOL", b"Solana", b"This is Solana token.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmWUy7LyKgnrNk9zR4fmAm5qhbHppRJuUUDt8gxNCJr1vJ/logo.PNG")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SOL>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOL>>(v2, @0x703cd1c1f68d239745a177b522a2f8651e8f8cd86e91ad9322cbec99b204ce38);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SOL>>(v1);
    }

    // decompiled from Move bytecode v6
}

