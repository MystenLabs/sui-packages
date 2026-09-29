module 0x4bcff399e2a74482f1d3ab9508b90e9dae412d038df8525ca4cbe7b3265dd0e6::derps {
    struct DERPS has drop {
        dummy_field: bool,
    }

    fun init(arg0: DERPS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DERPS>(arg0, 9, b"DERPS", b"DERPS", b"Trade Perps, Memes, and Tokens with Friends. Put crypto on easy mode with SuiNetwork", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/2101976982820880385/fXIIIxgC_400x400.jpg")), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<DERPS>>(0x2::coin::mint<DERPS>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DERPS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DERPS>>(v2, 0x2::address::from_u256(0));
    }

    // decompiled from Move bytecode v7
}

