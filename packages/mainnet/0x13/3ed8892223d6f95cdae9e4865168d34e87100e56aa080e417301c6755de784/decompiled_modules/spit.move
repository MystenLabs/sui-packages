module 0x133ed8892223d6f95cdae9e4865168d34e87100e56aa080e417301c6755de784::spit {
    struct SPIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPIT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPIT>(arg0, 6, b"SPIT", b"SuiPit", b"Suipit: the meme coin that spits in the face of scams! I lost a lot to frauds, so I created this token to stir things up and leave a mark on the SUI network. No nonsense, no Lambo promisesjust fun, memes, and blockchain. Lets laugh and symbolize the chaos!I only have X Twitter as a social network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Sw_Odug_UX_400x400_4860ec9787.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPIT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPIT>>(v1);
    }

    // decompiled from Move bytecode v6
}

