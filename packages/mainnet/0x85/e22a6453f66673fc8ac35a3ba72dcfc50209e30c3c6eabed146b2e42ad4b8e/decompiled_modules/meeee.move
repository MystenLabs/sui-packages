module 0x85e22a6453f66673fc8ac35a3ba72dcfc50209e30c3c6eabed146b2e42ad4b8e::meeee {
    struct MEEEE has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEEEE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEEEE>(arg0, 6, b"MEEEE", b"Meeseeks", b"We're not here to give you the same old spiel about \"safe investments\" and \"stable growth.\" Nah, we're the coin that turns up to the party, does the conga line naked, and screams, \"Look at me!\"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/MEESEEKS_305b647471.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEEEE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MEEEE>>(v1);
    }

    // decompiled from Move bytecode v6
}

