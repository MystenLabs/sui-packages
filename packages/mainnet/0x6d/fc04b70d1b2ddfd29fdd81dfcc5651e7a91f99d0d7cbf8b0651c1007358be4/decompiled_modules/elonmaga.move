module 0x6dfc04b70d1b2ddfd29fdd81dfcc5651e7a91f99d0d7cbf8b0651c1007358be4::elonmaga {
    struct ELONMAGA has drop {
        dummy_field: bool,
    }

    fun init(arg0: ELONMAGA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ELONMAGA>(arg0, 6, b"ELONMAGA", b"Elon Maga", b"As you can see, I'm not just MAGA, I'm dark MAGA.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/elon_25c8b58f92.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ELONMAGA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ELONMAGA>>(v1);
    }

    // decompiled from Move bytecode v6
}

