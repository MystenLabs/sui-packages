module 0x83db722c45437d6243bb9f8276f97b007c9d27a2ca20297bc7ad1c3aa27b4a29::neurai {
    struct NEURAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: NEURAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NEURAI>(arg0, 6, b"NEURAI", b"NEURATECH", b"Join us", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/neuratech_bef1c1b80a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NEURAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NEURAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

