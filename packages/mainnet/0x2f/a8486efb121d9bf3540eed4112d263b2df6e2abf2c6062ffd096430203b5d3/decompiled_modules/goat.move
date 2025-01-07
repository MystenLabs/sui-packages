module 0x2fa8486efb121d9bf3540eed4112d263b2df6e2abf2c6062ffd096430203b5d3::goat {
    struct GOAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOAT>(arg0, 6, b"Goat", b"HopGoat", b"Meet $HOPGOAT, the king of Sui chain! Fueled by meme energy, this goat dominates the scene alongside Hop Aggregator. More than just a meme coin, $HOPGOAT brings fun and boldness to the Sui chain, hopping to new heights. Get ready for the ultimate meme token thats set to lead the charge on Sui!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/a_Goat_78d8d41f7a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GOAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

