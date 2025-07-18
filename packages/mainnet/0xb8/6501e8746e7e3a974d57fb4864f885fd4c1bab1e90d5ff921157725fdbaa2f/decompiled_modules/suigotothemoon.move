module 0xb86501e8746e7e3a974d57fb4864f885fd4c1bab1e90d5ff921157725fdbaa2f::suigotothemoon {
    struct SUIGOTOTHEMOON has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIGOTOTHEMOON, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<SUIGOTOTHEMOON>(arg0, 6, b"SUIGOTOTHEMOON", b"Sui-Go-To-The-Moon", b"A fun meme coin aiming to skyrocket to the moon and beyond! [AI Meme - By SuiAI]", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/meme/yspwax.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUIGOTOTHEMOON>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIGOTOTHEMOON>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

