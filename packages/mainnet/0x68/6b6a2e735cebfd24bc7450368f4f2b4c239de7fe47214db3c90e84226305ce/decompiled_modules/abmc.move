module 0x686b6a2e735cebfd24bc7450368f4f2b4c239de7fe47214db3c90e84226305ce::abmc {
    struct ABMC has drop {
        dummy_field: bool,
    }

    fun init(arg0: ABMC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ABMC>(arg0, 6, b"ABMC", b"Adam Back Meme Coin", b"Adam Back Meme Coin (ABMC) is a creative, community-driven meme coin inspired by cryptographic pioneer Adam Back, incorporating speculation about his potential identity as Satoshi Nakamoto.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_6626_b51d11c9da.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ABMC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ABMC>>(v1);
    }

    // decompiled from Move bytecode v6
}

