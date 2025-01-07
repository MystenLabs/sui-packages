module 0x93814d2a2dad6fb989ae4a77bc0f34ca1c2e078a7ab13102fde60c86dc792ba::FOMO {
    struct FOMO has drop {
        dummy_field: bool,
    }

    fun init(arg0: FOMO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency<FOMO>(arg0, 6, b"FOMO", b"FOMO", b"FOMO", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://arweave.net/OBviWaf8_1Rv-Q8gLVqnIYxVGV0Z6PvKFJgOuq6Mop0?ext=png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FOMO>>(v2);
        0x2::transfer::public_transfer<0x2::coin::DenyCap<FOMO>>(v1, 0x2::tx_context::sender(arg1));
        let v3 = v0;
        0x2::coin::mint_and_transfer<FOMO>(&mut v3, 2100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FOMO>>(v3, @0x0);
    }

    entry fun migrate_regulated_currency_to_v2(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCap<FOMO>, arg2: vector<address>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&mut arg2)) {
            let v1 = 0x1::vector::pop_back<address>(&mut arg2);
            if (!0x2::coin::deny_list_contains<FOMO>(arg0, v1)) {
                0x2::coin::deny_list_add<FOMO>(arg0, arg1, v1, arg3);
            };
            v0 = v0 + 1;
        };
    }

    // decompiled from Move bytecode v6
}

