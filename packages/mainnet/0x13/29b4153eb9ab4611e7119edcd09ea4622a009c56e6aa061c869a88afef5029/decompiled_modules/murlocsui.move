module 0x1329b4153eb9ab4611e7119edcd09ea4622a009c56e6aa061c869a88afef5029::murlocsui {
    struct MURLOCSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MURLOCSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MURLOCSUI>(arg0, 6, b"MurlocSui", b"Murloc", b"The Yuren token initiated by the OG member of SUI and the NFT community is just a pure MEME with no investment value. We live in SUI and are happy every day.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/GYS_Tv8y_Wc_A_Am_M_Ev_3e56613d59.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MURLOCSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MURLOCSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

