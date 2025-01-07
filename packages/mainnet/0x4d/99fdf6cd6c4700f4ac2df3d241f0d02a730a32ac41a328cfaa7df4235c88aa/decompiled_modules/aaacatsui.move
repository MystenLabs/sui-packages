module 0x4d99fdf6cd6c4700f4ac2df3d241f0d02a730a32ac41a328cfaa7df4235c88aa::aaacatsui {
    struct AAACATSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: AAACATSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AAACATSUI>(arg0, 6, b"AAACATSUI", b"AAA CAT", b"So, Drippy stumbled upon this epic image of a black cat on Friday the 13th posted buy Sui Name Service and thought, \"Wow, this would make a fire meme coin!\" With all the buzz about Move Pump, Drippy wanted to test the meme creation tool on the platform. He created the token as a test and degens started to buy. He then posted it on his X account and all the Sui degens pushed it to complete the bonding curve within minutes. Now aaaCat is the fastest growing meme coin on Sui Network. aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_09_14_04_29_14_b75f2cb935.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AAACATSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AAACATSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

