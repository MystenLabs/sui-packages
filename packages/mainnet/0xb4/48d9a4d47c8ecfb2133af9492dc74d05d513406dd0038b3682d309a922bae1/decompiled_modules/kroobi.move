module 0xb448d9a4d47c8ecfb2133af9492dc74d05d513406dd0038b3682d309a922bae1::kroobi {
    struct KROOBI has drop {
        dummy_field: bool,
    }

    fun init(arg0: KROOBI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KROOBI>(arg0, 6, b"KROOBI", b"Sui Kroobi", b"Get ready to go full speed ahead into the next legendary crypto cycle ($KROOBI) Join the fun early  because when $KROOBI goes, it goes fast  and only the strongest will ride it to the top. No fear. Unlimited upside. 100% fundamental. $KROOBI isnt just a token  its a movement. Are you bullish enough?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20250428_064941_7fb5509bde.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KROOBI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KROOBI>>(v1);
    }

    // decompiled from Move bytecode v6
}

