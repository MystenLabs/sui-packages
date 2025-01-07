module 0x96cabe797ba9d6e6176782ee0acbcaf230b6a23a58fc748394359ae83e21dbfc::sprt {
    struct SPRT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPRT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPRT>(arg0, 6, b"SPRT", b"Spartanium", b"Meet Spartanium: the ultimate meme coin that blends humor with reliability. Combining legendary fun with secure investment, Spartanium is your top choice for a safe and entertaining crypto experience. Don't miss outjoin the meme revolution today", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/spartan3_bdcc4d4932.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPRT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPRT>>(v1);
    }

    // decompiled from Move bytecode v6
}

