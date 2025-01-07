module 0xdb0848d71c9044056d614d0fad0e6ce1a0e15a7518abf2f8c6bd793354ab238d::orly {
    struct ORLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: ORLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ORLY>(arg0, 6, b"ORLY", b"O RLY?", b"The O RLY? meme is an internet phenomenon that originated in the early 2000s. It features a snowy owl with the caption O RLY?, an abbreviation of Oh, really?. This image macro is typically used sarcastically in online forums and chats to express disbelief or to mock an obvious or dubious statement.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/B_Nz_P_Ff_MKHX_6_REQ_Gd_L_Zh_HC_3q_UE_Zmgk_WQZ_7d_HT_Syg_Cttv6_a95f596131.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ORLY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ORLY>>(v1);
    }

    // decompiled from Move bytecode v6
}

