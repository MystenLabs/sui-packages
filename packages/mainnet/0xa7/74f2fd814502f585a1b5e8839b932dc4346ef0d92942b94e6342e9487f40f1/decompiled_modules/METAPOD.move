module 0xa774f2fd814502f585a1b5e8839b932dc4346ef0d92942b94e6342e9487f40f1::METAPOD {
    struct METAPOD has drop {
        dummy_field: bool,
    }

    public entry fun transfer(arg0: 0x2::coin::Coin<METAPOD>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::Coin<METAPOD>>(arg0, arg1);
    }

    fun init(arg0: METAPOD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<METAPOD>(arg0, 9, b"POD", b"METAPOD", b"It is waiting for the moment to evolve. At this stage, it can only harden, so it remains motionless to avoid attack", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://assets.pokemon.com/assets/cms2/img/pokedex/full/011.png")), arg1);
        let v2 = v0;
        let v3 = 0x2::tx_context::sender(arg1);
        0x2::coin::mint_and_transfer<METAPOD>(&mut v2, 1000000000000000000, v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<METAPOD>>(v2, v3);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<METAPOD>>(v1);
    }

    entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<METAPOD>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<METAPOD>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

