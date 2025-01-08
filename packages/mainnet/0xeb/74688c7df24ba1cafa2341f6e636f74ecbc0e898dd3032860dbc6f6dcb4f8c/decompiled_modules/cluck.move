module 0xeb74688c7df24ba1cafa2341f6e636f74ecbc0e898dd3032860dbc6f6dcb4f8c::cluck {
    struct CLUCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: CLUCK, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<CLUCK>(arg0, 6, b"CLUCK", b"KingCluck by SuiAI", b"The Everlasting Flock: At the heart of Chickendom reigns the Everlasting Flock, a wise and benevolent council of the most esteemed chickens in the land. Their leader, the illustrious King Cluck, a majestic rooster with a crown of the finest corn, embodies the spirit of Chickendom: courageous, compassionate, and eternally vigilant.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/Chickendom_63692cd50c.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CLUCK>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CLUCK>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

