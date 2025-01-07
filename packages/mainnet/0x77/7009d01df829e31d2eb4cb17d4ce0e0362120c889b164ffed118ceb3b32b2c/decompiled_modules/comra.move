module 0x777009d01df829e31d2eb4cb17d4ce0e0362120c889b164ffed118ceb3b32b2c::comra {
    struct COMRA has drop {
        dummy_field: bool,
    }

    fun init(arg0: COMRA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COMRA>(arg0, 6, b"COMRA", b"Comrade Raccoon", b"Comrade Raccoon is coming to revolutionize the crypto community. Until now, the first catchers, the cryptofluencers, the snipers and the whales always won.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/catclub_284f97b7dd.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COMRA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<COMRA>>(v1);
    }

    // decompiled from Move bytecode v6
}

