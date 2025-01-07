module 0x6b494b71e26bdf683e042fdcfd423a331bccfba8a69ddf95d773934d3a1b7340::joker {
    struct JOKER has drop {
        dummy_field: bool,
    }

    fun init(arg0: JOKER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JOKER>(arg0, 6, b"JOKER", b"JOKER SUI", b"Joker Coin  Its your chance to enter the crypto world with a smile . Join the fun, but remember  anyone can be the trickster!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/n_Lc5_Fz_H8_400x400_5c1a169f65.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JOKER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JOKER>>(v1);
    }

    // decompiled from Move bytecode v6
}

