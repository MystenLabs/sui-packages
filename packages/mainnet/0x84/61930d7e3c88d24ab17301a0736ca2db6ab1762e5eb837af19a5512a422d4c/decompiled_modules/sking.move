module 0x8461930d7e3c88d24ab17301a0736ca2db6ab1762e5eb837af19a5512a422d4c::sking {
    struct SKING has drop {
        dummy_field: bool,
    }

    fun init(arg0: SKING, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SKING>(arg0, 6, b"Sking", b"Sui King", b"Sui King reigns supreme over the Sui Network, where innovation meets fun in the world of blockchain! As the charismatic leader of this vibrant community, Sui King embodies the spirit of creativity and excitement that fuels the memecoin revolution. With a crown of memes and a heart for crypto, he's here to transform the digital landscape and make Sui the talk of the town! With a mission to spread laughter and wealth, Sui King invites everyone to join the ride on this wild crypto journey. His kingdom thrives on collaboration, humor, and the joy of building something unique together. Whether you're a seasoned trader or new to the game, theres a place for you in Sui's realm. So grab your digital swords and prepare for battle, because under the rule of Sui King, we're not just making waveswe're making history! Join us as we meme our way to the moon, empowering each other and spreading the Sui spirit far and wide. Lets build a future where fun and finance go hand in hand!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suiking_5125db25e6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SKING>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SKING>>(v1);
    }

    // decompiled from Move bytecode v6
}

