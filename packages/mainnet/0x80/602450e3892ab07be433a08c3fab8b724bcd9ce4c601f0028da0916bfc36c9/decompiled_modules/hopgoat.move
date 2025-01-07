module 0x80602450e3892ab07be433a08c3fab8b724bcd9ce4c601f0028da0916bfc36c9::hopgoat {
    struct HOPGOAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOPGOAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOPGOAT>(arg0, 6, b"HopGoat", b"Goat on Hop", b"Meet $HOPGOAT, the king of Sui chain! Fueled by meme energy, this goat dominates the scene alongside Hop Aggregator. More than just a meme coin, $HOPGOAT brings fun and boldness to the Sui chain, hopping to new heights. Get ready for the ultimate meme token thats set to lead the charge on Sui!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/a_Goat_59f8a2c7f9.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOPGOAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HOPGOAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

