module 0x378c16768f91e99ef29900d8452a1b03a6057719f7090def173e1a144dd4c6e0::airdrop {
    struct AirdropConfig<phantom T0> has key {
        id: 0x2::object::UID,
        owner: address,
        balance: 0x2::balance::Balance<T0>,
        claimed: 0x2::table::Table<0x2::object::ID, bool>,
        airdrop_amount: u64,
    }

    public entry fun claim_airdrop<T0, T1: key>(arg0: &mut AirdropConfig<T0>, arg1: &T1, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<T1>());
        let v1 = 0x1::ascii::string(b"0x86fb9a85e3cfcc990f784ec8728bed55736adffea8c3b63f9dfb650957aabb40::staking::StakeReceipt");
        assert!(v0 == 0x1::ascii::string(b"0xc3fa73e68e5324871e0c9b2e67f61c3a594a62ab4b1128e781c5280f2702d116::bluemove_launchpad::HOMINIDS") || v0 == v1, 2);
        let v2 = 0x2::object::id<T1>(arg1);
        if (v0 == v1) {
            v2 = arg2;
        };
        assert!(!0x2::table::contains<0x2::object::ID, bool>(&arg0.claimed, v2), 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.balance, arg0.airdrop_amount, arg3), 0x2::tx_context::sender(arg3));
        0x2::table::add<0x2::object::ID, bool>(&mut arg0.claimed, v2, true);
    }

    public entry fun create_vault<T0>(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AirdropConfig<T0>{
            id             : 0x2::object::new(arg0),
            owner          : 0x2::tx_context::sender(arg0),
            balance        : 0x2::balance::zero<T0>(),
            claimed        : 0x2::table::new<0x2::object::ID, bool>(arg0),
            airdrop_amount : 1000000000000,
        };
        0x2::transfer::share_object<AirdropConfig<T0>>(v0);
    }

    public entry fun deposit_rewards<T0>(arg0: &mut AirdropConfig<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg2), 0);
        0x2::coin::put<T0>(&mut arg0.balance, arg1);
    }

    public entry fun withdraw_rewards<T0>(arg0: &mut AirdropConfig<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg2), 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.balance, arg1, arg2), 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

