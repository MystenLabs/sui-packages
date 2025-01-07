module 0x17a6b9c454e6509bfc4afa410d0d3ab727706a26b7fff9203bd28499176e9fdd::spkr {
    struct SPKR has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPKR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPKR>(arg0, 9, b"SPKR", b"Speakerman", b"Humanoids of the Skibidiverse, defending against the Skibidi Toilet invasion.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmbERLrbzAEvQqWPwUhSH5eb9w9fRJKsJB4CC4GGJRpLuS")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SPKR>(&mut v2, 999999402000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPKR>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPKR>>(v1);
    }

    // decompiled from Move bytecode v6
}

