module 0xfeee11b999bc03d99661e8c8da063cc82ffc179d324b63b9918d2c2b62685015::clawdsuneil {
    struct CLAWDSUNEIL has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<CLAWDSUNEIL>, arg1: 0x2::coin::Coin<CLAWDSUNEIL>) {
        0x2::coin::burn<CLAWDSUNEIL>(arg0, arg1);
    }

    fun init(arg0: CLAWDSUNEIL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CLAWDSUNEIL>(arg0, 6, b"CLAWD", b"ClawdSuneil", b"Personal assistant running inside OpenClaw", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/2017475267850293249/_-1uHyhh_400x400.png#1770274688344826000")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CLAWDSUNEIL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CLAWDSUNEIL>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<CLAWDSUNEIL>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<CLAWDSUNEIL>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

