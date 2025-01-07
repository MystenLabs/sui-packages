module 0x6ce630679b8d5e6191b7d1ab2a1596aa9e646fb9bf2cac2d4a4eb6ba3810cadd::zasui {
    struct ZASUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZASUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency<ZASUI>(arg0, 6, b"ZAS", b"Zasui", b"Zasui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/N_N_D_D_N_D_N_D_d1b423d435.png")), arg1);
        let v3 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZASUI>>(v0, v3);
        0x2::transfer::public_transfer<0x2::coin::DenyCap<ZASUI>>(v1, v3);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ZASUI>>(v2);
    }

    fun migrate_regulated_currency_to_v2(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCap<ZASUI>, arg2: vector<address>, arg3: &mut 0x2::tx_context::TxContext) {
        while (!0x1::vector::is_empty<address>(&arg2)) {
            let v0 = 0x1::vector::pop_back<address>(&mut arg2);
            if (!0x2::coin::deny_list_contains<ZASUI>(arg0, v0)) {
                0x2::coin::deny_list_add<ZASUI>(arg0, arg1, v0, arg3);
            };
        };
    }

    // decompiled from Move bytecode v6
}

