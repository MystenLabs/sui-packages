module 0x67501b88cb1d2caa2b9447d952090edad29ea59523351d4efd44f56f90b6e78a::duke {
    struct DUKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: DUKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DUKE>(arg0, 6, b"DUKE", b"Duke The Alien On Sui", b"Duke, an alien from Neptune, was fascinated by Earths crypto memes like Dogecoin and Shiba Inu", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/MEME_COIN_alien_2048x2048_318e581089.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DUKE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DUKE>>(v1);
    }

    // decompiled from Move bytecode v6
}

