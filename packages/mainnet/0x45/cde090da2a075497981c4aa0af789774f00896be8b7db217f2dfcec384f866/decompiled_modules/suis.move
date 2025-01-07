module 0x45cde090da2a075497981c4aa0af789774f00896be8b7db217f2dfcec384f866::suis {
    struct SUIS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<SUIS>(arg0, 6, b"SUIS", b"SuiSeason", b"It's the Sui Season. All the memes and the coins must a leader, a master, a king... A GOD. This god is named SuiSeason and will lead all the tokens to the 1B Market Cap...Follow the movement by investing in SuiSeason", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/suiseason_385a92e320.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUIS>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIS>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

