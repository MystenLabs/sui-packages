module 0x4281f65f0f57ab765a598abe62d49e05864764a6700ae042136e8e75110411cd::dogsu {
    struct DOGSU has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGSU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGSU>(arg0, 6, b"DOGSU", b"DOGE SUI", b"Dogecoin, the beloved meme-inspired cryptocurrency, has found a new home on the Sui blockchain. This move brings the playful spirit and community-driven nature of Dogecoin to a platform known for its high-performance and scalability.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/qweqeq_dbbe988a4e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGSU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOGSU>>(v1);
    }

    // decompiled from Move bytecode v6
}

