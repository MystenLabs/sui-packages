module 0x15bc481840f58aa355ea2386ef1e005b8129ba120f5657e3908ab68a5c17d28::sprc {
    struct SPRC has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPRC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPRC>(arg0, 6, b"SPRC", b"Shockpurr Coin", b"ShockPurr Coin is more than just a meme coin; it's a movement for surprise, fun and community driven growth!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/880d93dc_34bb_4388_b5c0_7fe926cb425d_cadadb1fde.JPG")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPRC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPRC>>(v1);
    }

    // decompiled from Move bytecode v6
}

