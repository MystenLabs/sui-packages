module 0x4295364fcacb05a51d5ccc044c53d57c3060894cd50cb719371b2d87cd8f01ec::adeniwif {
    struct ADENIWIF has drop {
        dummy_field: bool,
    }

    fun init(arg0: ADENIWIF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ADENIWIF>(arg0, 6, b"ADENIWIF", b"AdeniyiWifHat", b"The community rallies behind a charismatic leader. Adeniyi represents the team of braniacs at Mysten Labs, who have gifted us the Sui chain.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_20240922_180636_Telegram_2_9e7b19053c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ADENIWIF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ADENIWIF>>(v1);
    }

    // decompiled from Move bytecode v6
}

