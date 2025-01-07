module 0x66dfc0b129e9fb96048195e9b0525d82f84c998d8867c41b7b640ccaf1585b08::hopfish {
    struct HOPFISH has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOPFISH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOPFISH>(arg0, 6, b"HOPFISH", b"HopFish", b"They say fish don't jump, I'm an exception.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/GYRE_FIWAAA_4_Ke_Q_81268b78f7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOPFISH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HOPFISH>>(v1);
    }

    // decompiled from Move bytecode v6
}

