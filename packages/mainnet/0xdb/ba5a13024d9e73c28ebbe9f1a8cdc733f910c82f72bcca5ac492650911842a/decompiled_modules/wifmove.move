module 0xdbba5a13024d9e73c28ebbe9f1a8cdc733f910c82f72bcca5ac492650911842a::wifmove {
    struct WIFMOVE has drop {
        dummy_field: bool,
    }

    fun init(arg0: WIFMOVE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WIFMOVE>(arg0, 6, b"WIFMOVE", b"MoveWifHat", b"MOVEPUMP TOKEN WIF HAT VIBES ONCHAIN WIF FRENS.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/movewifhat_fbc8c45da9.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WIFMOVE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WIFMOVE>>(v1);
    }

    // decompiled from Move bytecode v6
}

