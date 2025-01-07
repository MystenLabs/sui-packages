module 0x47d2a41b85df8ae2d336fcac118eda298d8269c66022d09ebd1b0bfb5574b558::meee {
    struct MEEE has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEEE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEEE>(arg0, 6, b"MEEE", b"Mr Meeseeks", b"We're not here to give you the same old spiel about \"safe investments\" and \"stable growth.\" Nah, we're the coin that turns up to the party, does the conga line naked, and screams, \"Look at me!\"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/MEESEEKS_c480b9608d.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEEE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MEEE>>(v1);
    }

    // decompiled from Move bytecode v6
}

