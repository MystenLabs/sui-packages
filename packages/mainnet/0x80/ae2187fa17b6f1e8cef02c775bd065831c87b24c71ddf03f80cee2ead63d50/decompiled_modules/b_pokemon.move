module 0x80ae2187fa17b6f1e8cef02c775bd065831c87b24c71ddf03f80cee2ead63d50::b_pokemon {
    struct B_POKEMON has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_POKEMON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_POKEMON>(arg0, 9, b"bPOKEMON", b"bToken POKEMON", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_POKEMON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_POKEMON>>(v1);
    }

    // decompiled from Move bytecode v6
}

