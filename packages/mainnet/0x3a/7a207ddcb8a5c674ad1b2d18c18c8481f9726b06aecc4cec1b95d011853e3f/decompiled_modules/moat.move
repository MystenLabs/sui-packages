module 0x3a7a207ddcb8a5c674ad1b2d18c18c8481f9726b06aecc4cec1b95d011853e3f::moat {
    struct MOAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOAT>(arg0, 6, b"MOAT", b"Moat The Goat", b"Moat is a community-powered memecoin built on trust, culture, and the belief that crypto should be fun again. No empty promises, no complex narratives just a token that reflects the strength of its community.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeigz55ham6bwqkvfje63tmjjuwidour63yiyhxxfaep2xv24bicbnu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MOAT>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

