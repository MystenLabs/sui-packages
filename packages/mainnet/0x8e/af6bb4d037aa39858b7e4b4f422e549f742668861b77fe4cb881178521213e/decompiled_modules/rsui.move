module 0x8eaf6bb4d037aa39858b7e4b4f422e549f742668861b77fe4cb881178521213e::rsui {
    struct RSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: RSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RSUI>(arg0, 6, b"RSUI", b"SUI RISES", b"SUI RISES is the token that rises straight from the abyss, ready to surface and propel the Sui ecosystem to uncharted heights.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"http://movepump.xyz/uploads/SUI_PUMP_2_9859a102f3.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

