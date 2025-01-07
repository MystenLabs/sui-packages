module 0xefc81b087a2db2ba03b1bcd847117adc892fbb2108cc9ba3e23f0ce706de8843::sneilo {
    struct SNEILO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNEILO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SNEILO>(arg0, 6, b"SNEILO", b"SNEILO RUSH", b"Sneilo Rush is a play-to-earn crypto-based game on the SUI network. In this game, players can battle, collect, and upgrade their characters while earning tradeable crypto tokens. With SUI blockchain integration, Sneilo Rush offers an exciting gameplay experience along with opportunities to earn real rewards.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_6314600690156158320_x_e7137656ca.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SNEILO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SNEILO>>(v1);
    }

    // decompiled from Move bytecode v6
}

