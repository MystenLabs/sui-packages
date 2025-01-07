module 0x6a3a37b4d487f26d3551c48c444bfd83942563d112449ba71a59c0c0dc1f62de::fenn {
    struct FENN has drop {
        dummy_field: bool,
    }

    fun init(arg0: FENN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FENN>(arg0, 6, b"FENN", b"FENN SUI", b"$FENN - Party hard. Trade harder. Get rich.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_09_19_16_44_39_340815e5ce.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FENN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FENN>>(v1);
    }

    // decompiled from Move bytecode v6
}

