module 0x78e860eeee9255e1e6d6840417ad528c6ecc049138f12a80ebc6f3921fd51aa::suido {
    struct SUIDO has drop {
        dummy_field: bool,
    }

    public entry fun add_deny(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<SUIDO>, arg2: vector<address>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg2)) {
            0x2::coin::deny_list_v2_add<SUIDO>(arg0, arg1, *0x1::vector::borrow<address>(&arg2, v0), arg3);
            v0 = v0 + 1;
        };
    }

    public entry fun check_permission(arg0: &0x2::deny_list::DenyList, arg1: address) : bool {
        0x2::coin::deny_list_v2_contains_next_epoch<SUIDO>(arg0, arg1)
    }

    fun init(arg0: SUIDO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<SUIDO>(arg0, 9, b"SUIDO", b"Suido", b"The Matt Furie inspired new blue mascot of the blue chain.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://pbs.twimg.com/media/GaxfbcxbgAA8psJ?format=jpg&name=medium"))), false, arg1);
        let v3 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIDO>>(v2);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<SUIDO>>(v1, 0x2::tx_context::sender(arg1));
        0x2::coin::mint_and_transfer<SUIDO>(&mut v3, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<SUIDO>>(v3);
    }

    public entry fun remove_deny(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<SUIDO>, arg2: vector<address>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg2)) {
            0x2::coin::deny_list_v2_remove<SUIDO>(arg0, arg1, *0x1::vector::borrow<address>(&arg2, v0), arg3);
            v0 = v0 + 1;
        };
    }

    // decompiled from Move bytecode v6
}

