module 0x9ed724544d08091bb77fb604789ef85af96e79a5cb419213eec509857e23d054::mini {
    struct MINI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MINI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MINI>(arg0, 6, b"MINI", b"MinionsINU", b"The MinionsINU ecosystem will feature components such as Chain, Swap, Staking, NFT Marketplace, RPG Game, Anime Book, and Multiverse Studio", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/minions_logo_500x435_1_ca2a4668e0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MINI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MINI>>(v1);
    }

    // decompiled from Move bytecode v6
}

