module 0x92e1b5f28e24c95f63e3f1ecd77bbe85ba29ebc13d33ac6d60ccb6548ff65f58::suiking {
    struct SUIKING has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIKING, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIKING>(arg0, 6, b"Suiking", b"Sui King", b"Sui King reigns supreme over the Sui Network, where innovation meets fun in the world of blockchain! As the charismatic leader of this vibrant community, Sui King embodies the spirit of creativity and excitement that fuels the memecoin revolution. With a crown of memes and a heart for crypto, he's here to transform the digital landscape and make Sui the talk of the town! With a mission to spread laughter and wealth, Sui King invites everyone to join the ride on this wild crypto journey. His kingdom thrives on collaboration, humor, and the joy of building something unique together. Whether you're a seasoned trader or new to the game, theres a place for you in Sui's realm. So grab your digital swords and prepare for battle, because under the rule of Sui King, we're not just making waveswe're making history! Join us as we meme our way to the moon, empowering each other and spreading the Sui spirit far and wide. Lets build a future where fun and finance go hand in hand!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suiking_5125db25e6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIKING>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIKING>>(v1);
    }

    // decompiled from Move bytecode v6
}

