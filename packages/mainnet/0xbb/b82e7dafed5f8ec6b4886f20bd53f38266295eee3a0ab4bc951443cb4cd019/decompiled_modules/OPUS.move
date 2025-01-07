module 0xbbb82e7dafed5f8ec6b4886f20bd53f38266295eee3a0ab4bc951443cb4cd019::OPUS {
    struct OPUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: OPUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency<OPUS>(arg0, 2, b"OPUS", b"OPUS", b"OPUS", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://arweave.net/YcVSbWoV9-uStEQnrQUBfz9nrCdKwDkgYBnR9sLNU74?ext=png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OPUS>>(v2);
        0x2::transfer::public_transfer<0x2::coin::DenyCap<OPUS>>(v1, @0x7c3c58155b85c3ecf4864777fce255a7e405ffa3b6e443e736976588910f0e8d);
        let v3 = v0;
        0x2::coin::mint_and_transfer<OPUS>(&mut v3, 100000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OPUS>>(v3, 0x2::tx_context::sender(arg1));
    }

    entry fun migrate_regulated_currency_to_v2(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCap<OPUS>, arg2: vector<address>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&mut arg2)) {
            let v1 = 0x1::vector::pop_back<address>(&mut arg2);
            if (!0x2::coin::deny_list_contains<OPUS>(arg0, v1)) {
                0x2::coin::deny_list_add<OPUS>(arg0, arg1, v1, arg3);
            };
            v0 = v0 + 1;
        };
    }

    // decompiled from Move bytecode v6
}

