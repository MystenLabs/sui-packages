module 0x3cc1c0bffa2ea368e0557ecaa9b66c256d19404b6bb9bf5bc83ebaf99fba4bee::doll {
    struct DOLL has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOLL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOLL>(arg0, 6, b"DOLL", b"MOONDOLL", b"Meet The Moon Doll, a mysterious figure lurking in the shadows of the crypto realm, always watching and waiting for the perfect moment to strike. With cold eyes fixed on the lunar horizon and a quiet obsession with profits, The Moon Doll moves in silence, making strategic plays in the dark. Whether you're drawn in by curiosity or seeking gains, $Doll holds the key to fortunes hidden beneath the surface. Dare to follow this eerie path, but bewareonce you're in, there's no turning back.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/avatar_3db238c4d5.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOLL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOLL>>(v1);
    }

    // decompiled from Move bytecode v6
}

