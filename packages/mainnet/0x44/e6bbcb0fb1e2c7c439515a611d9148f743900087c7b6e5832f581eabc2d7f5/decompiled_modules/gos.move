module 0x44e6bbcb0fb1e2c7c439515a611d9148f743900087c7b6e5832f581eabc2d7f5::gos {
    struct GOS has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOS>(arg0, 6, b"GOS", b"Gorilla on Sui", b"The Meme Coin with a Jungle of Possibilities.Gorilla Sui NFT Collection  The Next Level .", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Gorilla_Rugby_Team_114_b38a7d5bd8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GOS>>(v1);
    }

    // decompiled from Move bytecode v6
}

