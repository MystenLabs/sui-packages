module 0x8accdd0d7776b9bd5ca003c70f8d9bd830e549d1511cc4a98491d6ce0727e61d::limitorder_collector {
    struct LimitorderCollector has store, key {
        id: 0x2::object::UID,
        deposit_cap: 0xadb5d562984cde3cad2401b1067e7b52816d2e9f7a1e6ed4f4a6c94ddb50db51::vault::DepositCap,
    }

    struct CreateLimitorderCollectorEvent has copy, drop, store {
        id: 0x2::object::ID,
        deposit_cap_id: 0x2::object::ID,
    }

    public fun create(arg0: 0xadb5d562984cde3cad2401b1067e7b52816d2e9f7a1e6ed4f4a6c94ddb50db51::vault::DepositCap, arg1: &0x8accdd0d7776b9bd5ca003c70f8d9bd830e549d1511cc4a98491d6ce0727e61d::admin_cap::AdminCap, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = LimitorderCollector{
            id          : 0x2::object::new(arg2),
            deposit_cap : arg0,
        };
        let v1 = CreateLimitorderCollectorEvent{
            id             : 0x2::object::id<LimitorderCollector>(&v0),
            deposit_cap_id : 0x2::object::id<0xadb5d562984cde3cad2401b1067e7b52816d2e9f7a1e6ed4f4a6c94ddb50db51::vault::DepositCap>(&arg0),
        };
        0x2::event::emit<CreateLimitorderCollectorEvent>(v1);
        0x2::transfer::public_share_object<LimitorderCollector>(v0);
    }

    public fun deposit_fee<T0>(arg0: &LimitorderCollector, arg1: &mut 0xadb5d562984cde3cad2401b1067e7b52816d2e9f7a1e6ed4f4a6c94ddb50db51::vault::Vault, arg2: 0x2::coin::Coin<T0>, arg3: &0xadb5d562984cde3cad2401b1067e7b52816d2e9f7a1e6ed4f4a6c94ddb50db51::versioned::Versioned) {
        assert!(0xadb5d562984cde3cad2401b1067e7b52816d2e9f7a1e6ed4f4a6c94ddb50db51::vault::vault_id(&arg0.deposit_cap) == 0x2::object::id<0xadb5d562984cde3cad2401b1067e7b52816d2e9f7a1e6ed4f4a6c94ddb50db51::vault::Vault>(arg1), 13906834367616909313);
        0xadb5d562984cde3cad2401b1067e7b52816d2e9f7a1e6ed4f4a6c94ddb50db51::vault::deposit_coin<T0>(arg1, arg2, &arg0.deposit_cap, arg3);
    }

    // decompiled from Move bytecode v6
}

