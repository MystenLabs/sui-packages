module 0x6f2609c06edf248c15c0b2e5b17542fe6dac43577a486946b5a28bec6106b382::REALIS {
    struct REALIS has drop {
        dummy_field: bool,
    }

    fun init(arg0: REALIS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency<REALIS>(arg0, 2, b"REALIS", b"Realis Worlds", b"Realis Worlds", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://arweave.net/FIaq-J21ICN2c64sfmR8a5jg35Fa3e2QB8Mcz-miHvk?ext=png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<REALIS>>(v2);
        0x2::transfer::public_transfer<0x2::coin::DenyCap<REALIS>>(v1, @0x8bcc0e6cadf05f36018b1dff59d669b358a5aad6e5d05ad00bda60873cf0cb5c);
        let v3 = v0;
        0x2::coin::mint_and_transfer<REALIS>(&mut v3, 100000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<REALIS>>(v3, 0x2::tx_context::sender(arg1));
    }

    entry fun migrate_regulated_currency_to_v2(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCap<REALIS>, arg2: vector<address>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&mut arg2)) {
            let v1 = 0x1::vector::pop_back<address>(&mut arg2);
            if (!0x2::coin::deny_list_contains<REALIS>(arg0, v1)) {
                0x2::coin::deny_list_add<REALIS>(arg0, arg1, v1, arg3);
            };
            v0 = v0 + 1;
        };
    }

    // decompiled from Move bytecode v6
}

