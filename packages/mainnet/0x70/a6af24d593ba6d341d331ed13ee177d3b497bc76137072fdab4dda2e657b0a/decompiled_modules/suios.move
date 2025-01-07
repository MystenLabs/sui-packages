module 0x70a6af24d593ba6d341d331ed13ee177d3b497bc76137072fdab4dda2e657b0a::suios {
    struct SUIOS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIOS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIOS>(arg0, 6, b"SUIOS", b"SuiosOnSui", b"$SUIOS meme coin sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000000166_fa2a91af6f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIOS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIOS>>(v1);
    }

    // decompiled from Move bytecode v6
}

