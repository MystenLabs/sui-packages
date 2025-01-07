module 0x59740f4074674c9ac47851dbf8aa9a57abef71ba1ed8de2f82c48dcb4d4ce5cb::npc {
    struct NPC has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<NPC>, arg1: 0x2::coin::Coin<NPC>) {
        0x2::coin::burn<NPC>(arg0, arg1);
    }

    fun init(arg0: NPC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<NPC>(arg0, 9, b"NPC", b"NPC", b"Team rugged and abandoned project", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/Eq39Q9bwTx1YHY5pkHLVeahVA6JYZmmMJ71rPjQek3Hb.png?size=xl&key=ec67c3")), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<NPC>(&mut v3, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NPC>>(v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NPC>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<NPC>>(v1, @0x92d7e26079435f31e36c126ac3fa3f8d6590f35b7e21a074f2510c38f527c289);
    }

    public fun migrate_currency_to_v2(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<NPC>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<NPC>(arg0, arg1, arg2, arg3);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<NPC>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<NPC>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

