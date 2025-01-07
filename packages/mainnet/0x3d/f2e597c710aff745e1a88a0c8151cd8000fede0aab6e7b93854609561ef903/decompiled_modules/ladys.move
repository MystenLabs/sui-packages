module 0x3df2e597c710aff745e1a88a0c8151cd8000fede0aab6e7b93854609561ef903::ladys {
    struct LADYS has drop {
        dummy_field: bool,
    }

    fun init(arg0: LADYS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LADYS>(arg0, 6, b"LADYS", b"Milady", b"LADYS may not be the meme coin Miladys wanted, but LADYS is the meme coin Miladys needs in this age of unbridled meme power. You like art, we make coins.. Miladys knew this coin would come.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/0xe03e306466965d242db8c562ba2ce230472ca9b3_411417e481.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LADYS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LADYS>>(v1);
    }

    // decompiled from Move bytecode v6
}

