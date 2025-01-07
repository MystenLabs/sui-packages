module 0x53abeee3398e7dc493097083e0befa3bf37e9b52cc0aae8f5bf2559661a30122::suisyan {
    struct SUISYAN has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SUISYAN>, arg1: 0x2::coin::Coin<SUISYAN>) {
        0x2::coin::burn<SUISYAN>(arg0, arg1);
    }

    fun init(arg0: SUISYAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<SUISYAN>(arg0, 9, b"SUISYAN", b"SUI SAIYAN", b"Burnnnnnnnnn SUI SAIYAN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cdn.discordapp.com/attachments/1309371179760615434/1309392500179468289/AVA.jpeg?ex=67416a4b&is=674018cb&hm=253859b0f0b33756d7f0e69118ba23f6060b3e290c066c01b97e17ed06888112&")), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<SUISYAN>(&mut v3, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUISYAN>>(v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUISYAN>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<SUISYAN>>(v1, @0x2481c01fe95e26a2aafbfdbffb291cab0853984495e9e4ae8ae39bf83be65a20);
    }

    public fun migrate_currency_to_v2(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<SUISYAN>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<SUISYAN>(arg0, arg1, arg2, arg3);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SUISYAN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SUISYAN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

