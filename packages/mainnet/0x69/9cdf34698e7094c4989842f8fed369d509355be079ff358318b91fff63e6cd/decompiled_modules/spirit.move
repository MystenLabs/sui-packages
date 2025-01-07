module 0x699cdf34698e7094c4989842f8fed369d509355be079ff358318b91fff63e6cd::spirit {
    struct SPIRIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPIRIT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPIRIT>(arg0, 6, b"SPIRIT", b"Sui Spirit", b"I'm Spirit", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ghst_e914b780db.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPIRIT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPIRIT>>(v1);
    }

    // decompiled from Move bytecode v6
}

