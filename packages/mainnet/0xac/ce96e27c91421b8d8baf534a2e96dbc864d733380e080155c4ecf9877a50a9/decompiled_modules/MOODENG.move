module 0xacce96e27c91421b8d8baf534a2e96dbc864d733380e080155c4ecf9877a50a9::MOODENG {
    struct MOODENG has drop {
        dummy_field: bool,
    }

    entry fun block_accounts(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCap<MOODENG>, arg2: vector<address>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&mut arg2)) {
            let v1 = 0x1::vector::pop_back<address>(&mut arg2);
            if (!0x2::coin::deny_list_contains<MOODENG>(arg0, v1)) {
                0x2::coin::deny_list_add<MOODENG>(arg0, arg1, v1, arg3);
            };
            v0 = v0 + 1;
        };
    }

    fun init(arg0: MOODENG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency<MOODENG>(arg0, 6, b"moodeng", b"SUI MOODENG", b"Moo Deng on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://arweave.net/p8012Z0yD9x5h4s5VvXYsSShT4IyROYO7h-Ozg-e3JM?ext=png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MOODENG>>(v2);
        0x2::transfer::public_transfer<0x2::coin::DenyCap<MOODENG>>(v1, 0x2::tx_context::sender(arg1));
        let v3 = v0;
        0x2::coin::mint_and_transfer<MOODENG>(&mut v3, 100000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOODENG>>(v3, @0x0);
    }

    // decompiled from Move bytecode v6
}

