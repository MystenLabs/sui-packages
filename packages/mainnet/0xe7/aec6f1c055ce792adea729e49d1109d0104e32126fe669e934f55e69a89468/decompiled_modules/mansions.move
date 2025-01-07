module 0xe7aec6f1c055ce792adea729e49d1109d0104e32126fe669e934f55e69a89468::mansions {
    struct MANSIONS has drop {
        dummy_field: bool,
    }

    fun init(arg0: MANSIONS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MANSIONS>(arg0, 6, b"MANSIONS", b"EGOROV MANSIONS", b"Curve Finance founder mansions )meme( #mansions", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/learn_Mich_Egorov_coins_curve_covers_neutral_2_850x478_119e73f347.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MANSIONS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MANSIONS>>(v1);
    }

    // decompiled from Move bytecode v6
}

