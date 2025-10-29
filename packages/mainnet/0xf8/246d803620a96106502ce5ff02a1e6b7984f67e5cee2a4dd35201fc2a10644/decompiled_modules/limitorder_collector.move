module 0x101ceaafe0660e492c7b3f27525d52b5fb42992eeb5181eb19621ea89d1bd637::limitorder_collector {
    struct LimitorderCollector has store, key {
        id: 0x2::object::UID,
        deposit_cap: 0xa609c916c2c64226ee928aa55449575daf21caa95afd9a1ed10f4e237d6faaf9::vault::DepositCap,
    }

    struct CreateLimitorderCollectorEvent has copy, drop, store {
        id: 0x2::object::ID,
        deposit_cap_id: 0x2::object::ID,
    }

    public fun create_limitorder_collector(arg0: 0xa609c916c2c64226ee928aa55449575daf21caa95afd9a1ed10f4e237d6faaf9::vault::DepositCap, arg1: &0x101ceaafe0660e492c7b3f27525d52b5fb42992eeb5181eb19621ea89d1bd637::admin_cap::AdminCap, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = LimitorderCollector{
            id          : 0x2::object::new(arg2),
            deposit_cap : arg0,
        };
        let v1 = CreateLimitorderCollectorEvent{
            id             : 0x2::object::id<LimitorderCollector>(&v0),
            deposit_cap_id : 0x2::object::id<0xa609c916c2c64226ee928aa55449575daf21caa95afd9a1ed10f4e237d6faaf9::vault::DepositCap>(&arg0),
        };
        0x2::event::emit<CreateLimitorderCollectorEvent>(v1);
        0x2::transfer::public_share_object<LimitorderCollector>(v0);
    }

    public fun deposit_fee<T0>(arg0: &mut LimitorderCollector, arg1: &mut 0xa609c916c2c64226ee928aa55449575daf21caa95afd9a1ed10f4e237d6faaf9::vault::Vault, arg2: 0x2::coin::Coin<T0>, arg3: &0xa609c916c2c64226ee928aa55449575daf21caa95afd9a1ed10f4e237d6faaf9::versioned::Versioned) {
        assert!(0xa609c916c2c64226ee928aa55449575daf21caa95afd9a1ed10f4e237d6faaf9::vault::vault_id(&arg0.deposit_cap) == 0x2::object::id<0xa609c916c2c64226ee928aa55449575daf21caa95afd9a1ed10f4e237d6faaf9::vault::Vault>(arg1), 13906834367616909313);
        0xa609c916c2c64226ee928aa55449575daf21caa95afd9a1ed10f4e237d6faaf9::vault::deposit_coin<T0>(arg1, arg2, &mut arg0.deposit_cap, arg3);
    }

    // decompiled from Move bytecode v6
}

