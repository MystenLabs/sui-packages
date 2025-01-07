module 0xff9dd2f7e47f3c95ebe9287d78402a06fe0886600919c89fb654593140ef3394::DIGI {
    struct DIGI has drop {
        dummy_field: bool,
    }

    fun init(arg0: DIGI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency<DIGI>(arg0, 2, b"DIGI", b"Digicoin", b"Digicoin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://arweave.net/Q_VRwMz56zCnV8sYqZ7qpNzYV-untD_8GprWpwllCsY?ext=png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DIGI>>(v2);
        0x2::transfer::public_transfer<0x2::coin::DenyCap<DIGI>>(v1, @0x7c3c58155b85c3ecf4864777fce255a7e405ffa3b6e443e736976588910f0e8d);
        let v3 = v0;
        0x2::coin::mint_and_transfer<DIGI>(&mut v3, 100000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DIGI>>(v3, 0x2::tx_context::sender(arg1));
    }

    entry fun migrate_regulated_currency_to_v2(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCap<DIGI>, arg2: vector<address>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&mut arg2)) {
            let v1 = 0x1::vector::pop_back<address>(&mut arg2);
            if (!0x2::coin::deny_list_contains<DIGI>(arg0, v1)) {
                0x2::coin::deny_list_add<DIGI>(arg0, arg1, v1, arg3);
            };
            v0 = v0 + 1;
        };
    }

    // decompiled from Move bytecode v6
}

