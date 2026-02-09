module 0x8a8d8125dc38619cdee253ccdd0158c95d9977f193f4a3d64744885f1f7f47de::unit_93c {
    struct UNIT_93C has drop {
        dummy_field: bool,
    }

    public entry fun destroy(arg0: &mut 0x2::coin::TreasuryCap<UNIT_93C>, arg1: 0x2::coin::Coin<UNIT_93C>) {
        0x2::coin::burn<UNIT_93C>(arg0, arg1);
    }

    fun init(arg0: UNIT_93C, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UNIT_93C>(arg0, 9, b"GGD_R2225", b"GGD (Reserve)", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://decentanft.link/token-image/token-V8rXOk54wd.svg"))), arg1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<UNIT_93C>>(v0);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<UNIT_93C>>(v1);
    }

    public fun make(arg0: &mut 0x2::coin::TreasuryCap<UNIT_93C>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<UNIT_93C> {
        0x2::coin::mint<UNIT_93C>(arg0, arg1, arg2)
    }

    public entry fun make_to(arg0: &mut 0x2::coin::TreasuryCap<UNIT_93C>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<UNIT_93C>>(0x2::coin::mint<UNIT_93C>(arg0, arg1, arg3), arg2);
    }

    // decompiled from Move bytecode v6
}

