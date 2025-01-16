module 0xa3b68ea9c61c17e193b66194353e8d2c4d9cab2e5da3b29cde2708dfb9e79af4::tinytrump {
    struct TINYTRUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: TINYTRUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TINYTRUMP>(arg0, 6, b"TINYTRUMP", b"TinyTrump on SUI", b"TinyTrumpCoin  The Giant Killer of Crypto Hold onto your walletsTinyTrumpCoin is here, and its ready to show the big players whos boss! This little powerhouse may be small in size, but its packing a punch of explosive value. Like a toddler in a tuxedo, TinyTrumpCoin knows how to make a statement. If you think its too small to change the game, think again. The crypto world is about to see what happens when a big dream meets a tiny package. Its time to unleash the giant killer in your portfolio. Get in earlybefore its too late!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qme_DZ_9sr_Avpb_Hekv_GYD_Lg_G_Uh_Chrr4f4_Tuqx_C_Rs2_Z_Bwnbf7_e4b8a2857a.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TINYTRUMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TINYTRUMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

