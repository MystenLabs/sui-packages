module 0xf8ecdb9606c6ad3a656082e6bb4ba3a60c0557cdbd9ef8840278b85a88263ae::helios {
    struct HELIOS has drop {
        dummy_field: bool,
    }

    fun init(arg0: HELIOS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HELIOS>(arg0, 6, b"HELIOS", b"Helios AI", b"Helios Ai is a carnot engine fueling the ai economy from data user", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000028307_5e5760b263.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HELIOS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HELIOS>>(v1);
    }

    // decompiled from Move bytecode v6
}

