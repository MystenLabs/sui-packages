module 0x855cb6fdacfa2dcbc167cb570fd181c125f64f96f603aff00f4736d7175be516::ZSUI {
    struct ZSUI has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<ZSUI>, arg1: 0x2::coin::Coin<ZSUI>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::coin::burn<ZSUI>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<ZSUI>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<ZSUI>>(0x2::coin::mint<ZSUI>(arg0, arg1, arg3), arg2);
    }

    public entry fun freeze_treasury_cap(arg0: 0x2::coin::TreasuryCap<ZSUI>) {
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<ZSUI>>(arg0);
    }

    fun init(arg0: ZSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZSUI>(arg0, 9, b"ZSUI", b"DragonBallZonSui", b"Explosive Dragon Ball Z-inspired crypto on Sui's blazing-fast blockchain. Unstoppable growth awaits!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suirewards.me/coinphp/uploads/img_685255471c0181.07843714.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ZSUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZSUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

