module 0xf87bb9c7144fba727c68e948d8ff68ff542bebea3687964e09a20492ba758c74::dwog {
    struct DWOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: DWOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DWOG>(arg0, 6, b"Dwog", b"Dwog Retarded", b"Dwog, often dubbed the Retarded Doge, emerged as an accidental offshoot in the wake of Fwog the Frogs meme coin mania. While Fwog hopped onto the scene with a cunning grin and sharp wit, Dwog stumbled in with his endearingly vacant stare and droopy tongue.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_09_11_06_45_9bd3ea621b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DWOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DWOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

