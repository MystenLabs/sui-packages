module 0x7df30ba1ba8a028446d5634b438624f127b9312bf4bcec524db29a50aab61d70::digis {
    struct DIGIS has drop {
        dummy_field: bool,
    }

    fun init(arg0: DIGIS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DIGIS>(arg0, 6, b"DIGIS", b"DIGIMONS ARE IN SUI", b"Welcome all the DIGIMONS in this meta. $DIGIS are here to take over the POKEMONS.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeideykkfx2xerrhlbtl2e3lbabsbjxhq76ntydm3kjypubdww4knau")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DIGIS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DIGIS>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

