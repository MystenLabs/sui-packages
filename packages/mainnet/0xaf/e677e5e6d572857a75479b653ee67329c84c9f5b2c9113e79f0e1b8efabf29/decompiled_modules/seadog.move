module 0xafe677e5e6d572857a75479b653ee67329c84c9f5b2c9113e79f0e1b8efabf29::seadog {
    struct SEADOG has drop {
        dummy_field: bool,
    }

    public entry fun transfer(arg0: 0x2::coin::Coin<SEADOG>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<SEADOG>>(arg0, arg1);
    }

    public entry fun approve(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<SEADOG>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<SEADOG>(arg0, arg1, arg2, arg3);
    }

    public entry fun approved(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<SEADOG>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<SEADOG>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: SEADOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<SEADOG>(arg0, 2, b"SEADOG", b"SEADOG", b"Seadog Coin is your trusty companion on Sui! Navigate the crypto waves with strength and loyalty. https://suibull.tech/ - https://t.me/Suibullcon - https://x.com/bullsuicoin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://suibull.tech/images/logo.jpg"))), false, arg1);
        let v3 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SEADOG>>(v2);
        let v4 = 0x2::tx_context::sender(arg1);
        0x2::coin::mint_and_transfer<SEADOG>(&mut v3, 100000, v4, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SEADOG>>(v3, v4);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<SEADOG>>(v1, v4);
    }

    // decompiled from Move bytecode v6
}

