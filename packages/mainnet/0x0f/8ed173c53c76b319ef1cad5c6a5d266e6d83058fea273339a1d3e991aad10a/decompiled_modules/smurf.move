module 0xf8ed173c53c76b319ef1cad5c6a5d266e6d83058fea273339a1d3e991aad10a::smurf {
    struct SMURF has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMURF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMURF>(arg0, 6, b"SMURF", b"SMURFYY", b"Suimurf is the perfect bringing a new wave of excitement to the crypto space. Suimurfe combines charm, humor, and community spirit to create a unique memecoin experience.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_31d08a15c5_0817098b74.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMURF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SMURF>>(v1);
    }

    // decompiled from Move bytecode v6
}

