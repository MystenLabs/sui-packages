module 0x449bf23a27533286c50c290a1115dfc782dcb2641502bd4db8096fa960e80364::jenitortoise {
    struct JENITORTOISE has drop {
        dummy_field: bool,
    }

    fun init(arg0: JENITORTOISE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JENITORTOISE>(arg0, 6, b"Jenitortoise", b"SUI", b"CommonCo-build Sui onTogether to build the world's best meme, if you also like Jenny turtle.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000012821_455fae63f3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JENITORTOISE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JENITORTOISE>>(v1);
    }

    // decompiled from Move bytecode v6
}

