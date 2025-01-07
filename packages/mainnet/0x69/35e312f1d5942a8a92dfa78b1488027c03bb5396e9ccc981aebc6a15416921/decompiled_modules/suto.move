module 0x6935e312f1d5942a8a92dfa78b1488027c03bb5396e9ccc981aebc6a15416921::suto {
    struct SUTO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUTO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUTO>(arg0, 6, b"SUTO", b"SUITOSHI", b"From Satoshis vision to Suis speed, Suitoshi is the evolution of crypto legends  one meme at a time.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/OIG_1_Z_Xs_B_Ugc_70e99bde92.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUTO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUTO>>(v1);
    }

    // decompiled from Move bytecode v6
}

