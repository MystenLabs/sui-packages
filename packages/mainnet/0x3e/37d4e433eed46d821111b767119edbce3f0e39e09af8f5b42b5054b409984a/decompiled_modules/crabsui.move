module 0x3e37d4e433eed46d821111b767119edbce3f0e39e09af8f5b42b5054b409984a::crabsui {
    struct CRABSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: CRABSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CRABSUI>(arg0, 6, b"CRABSUI", b"CRAB PHILO SUI PHY", b"The Crab meme on SUI symbolizing resilience and community spirit in crypto.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Leonardo_Anime_XL_a_funny_crab_cartoon_icon_for_a_meme_coin_sy_0_e2dca1511c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CRABSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CRABSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

