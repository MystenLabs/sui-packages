module 0x7b5258fb52d60661434f7cc5ed0b30d4f8b5109f7b31b5ce0adbc723fb3787d0::doge {
    struct DOGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGE>(arg0, 6, b"Doge", b"Fuku..", b"where the power of a tsunami meets the playful spirit of a surf-loving Shiba Inu. This isn't just another token; it's a tidal wave of innovation on the Sui Blockchain. Surfing through the crypto market with unparalleled speed and agility, $fuku represents the force of nature in the world of digital currency.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000022052_df667b5ccf.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOGE>>(v1);
    }

    // decompiled from Move bytecode v6
}

