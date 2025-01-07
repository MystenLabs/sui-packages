module 0xd61a5b4e13a28c63e81931d2025cfc200a3707bf4caa2d89810f0c30d3ca735b::hoppy {
    struct HOPPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOPPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOPPY>(arg0, 6, b"HOPPY", b"Hoppy", b"$HOPPY is the fastest rabbit on the SUI network, hopping between transactions like theyre golden carrots. With boundless energy and a mischievous vibe, he turns every trade into a wild adventure. While others try to keep up, $HOPPY's already on the moon, spreading cryptos and smiles with his swift paws. Hop high, go further!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_11_13_08_08_e5f1c2c0cf.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOPPY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HOPPY>>(v1);
    }

    // decompiled from Move bytecode v6
}

