module 0x13347e2f477b2d73064e86fcdedca84cafde24d28373d4c24ff20c40b13e2744::rizzeve {
    struct RIZZEVE has drop {
        dummy_field: bool,
    }

    fun init(arg0: RIZZEVE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RIZZEVE>(arg0, 6, b"RIZZEVE", b"Rizz Year's Eve", b"Rizz Years Eve is the ultimate token to celebrate the art of charm, confidence, and celebration. With its launch coinciding with the year's most exciting event  New Year's Eve  Rizz Years Eve brings together a community of individuals who know how to bring the \"rizz\" to the party. Whether you're ringing in the new year or just looking to level up your crypto game, Rizz Years Eve  is all about seizing the moment and making every occasion unforgettable.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241128_183516_389_ff92508112.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RIZZEVE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RIZZEVE>>(v1);
    }

    // decompiled from Move bytecode v6
}

