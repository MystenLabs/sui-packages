module 0xce31b92baf3f24233f7fc68441ff6ec4c1959f51459e74f2a6f2e3643ae6f8ba::opta {
    struct OPTA has drop {
        dummy_field: bool,
    }

    fun init(arg0: OPTA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OPTA>(arg0, 6, b"OPTA", b"potato", b"After all the memes we have seen over many years, here comes the potato, which, despite its importance, remains undervalued and often forgotten. The potato is an integral part of the cultures of all peoples on Earth throughout history. It has been a savior for humanity during famines and crises in various parts of the world.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_U_U_U_U_U_U_U_U_U_U_U_U_U_U_59302fabf6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OPTA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OPTA>>(v1);
    }

    // decompiled from Move bytecode v6
}

