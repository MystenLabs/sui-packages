module 0xfef4237df0ac16bcaa599542f46ddeae56ada7cb5a48faf6465d8a6ba57fc9fa::dollar {
    struct DOLLAR has drop {
        dummy_field: bool,
    }

    struct CapWrapper has key {
        id: 0x2::object::UID,
        cap: 0x2::coin::TreasuryCap<DOLLAR>,
    }

    public fun burn(arg0: &mut CapWrapper, arg1: 0x2::coin::Coin<DOLLAR>) : u64 {
        0x2::coin::burn<DOLLAR>(&mut arg0.cap, arg1)
    }

    public(friend) fun mint(arg0: &mut CapWrapper, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<DOLLAR> {
        0x2::coin::mint<DOLLAR>(&mut arg0.cap, arg1, arg2)
    }

    fun init(arg0: DOLLAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOLLAR>(arg0, 9, b"DOGAI", b"DOGAI", b"First AI-driven memecoin dog ever.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://node1.irys.xyz/55zWHav-jQbBLV1FHX-kEM8tJougBOFmJlwOS_kMuo8"))), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<DOLLAR>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DOLLAR>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOLLAR>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

