module 0x2bdbbe76694635d17d1ef30c1a3e498cbf1e7bdd2d9cd3018a302eba83b91066::sktang {
    struct SKTANG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SKTANG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SKTANG>(arg0, 6, b"SKTANG", b"SKI MASK TANG CAT", b"Ski Mask Tang Cat merges two iconic meme coinsSki Mask Dog and Tang Catinto one unique, hilarious meme. Backed by the power of sui communities. Ski Mask Tang Cat is a fun, bold investment for those who love Ski Mask and Tang Cat! Less build this Ski Tang Clan up", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000031698_1600487b5a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SKTANG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SKTANG>>(v1);
    }

    // decompiled from Move bytecode v6
}

