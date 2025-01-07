module 0x517e473f851519fb27a5d0bd52315e28c18c04956524424b6b1fea2ab269d3d7::AAA {
    struct AAA has drop {
        dummy_field: bool,
    }

    fun init(arg0: AAA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency<AAA>(arg0, 2, b"AAA", b"AAACTO", b"AAACTO", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://arweave.net/sbnpsulW4LXK1WJqsrZ8vC-PzqDjOuOro1HqGEhcENo?ext=png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AAA>>(v2);
        0x2::transfer::public_transfer<0x2::coin::DenyCap<AAA>>(v1, @0x7c3c58155b85c3ecf4864777fce255a7e405ffa3b6e443e736976588910f0e8d);
        let v3 = v0;
        0x2::coin::mint_and_transfer<AAA>(&mut v3, 100000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AAA>>(v3, 0x2::tx_context::sender(arg1));
    }

    entry fun migrate_regulated_currency_to_v2(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCap<AAA>, arg2: vector<address>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&mut arg2)) {
            let v1 = 0x1::vector::pop_back<address>(&mut arg2);
            if (!0x2::coin::deny_list_contains<AAA>(arg0, v1)) {
                0x2::coin::deny_list_add<AAA>(arg0, arg1, v1, arg3);
            };
            v0 = v0 + 1;
        };
    }

    // decompiled from Move bytecode v6
}

