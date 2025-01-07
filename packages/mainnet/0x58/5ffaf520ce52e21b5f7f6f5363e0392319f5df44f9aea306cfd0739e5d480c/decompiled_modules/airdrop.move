module 0x585ffaf520ce52e21b5f7f6f5363e0392319f5df44f9aea306cfd0739e5d480c::airdrop {
    struct AirdropConfig<phantom T0, phantom T1: key, phantom T2> has key {
        id: 0x2::object::UID,
        owner: address,
        balance: 0x2::balance::Balance<T0>,
        claimed: 0x2::table::Table<0x2::object::ID, bool>,
        airdrop_amount: u64,
    }

    public entry fun claim_airdrop<T0, T1: key, T2>(arg0: &mut AirdropConfig<T0, T1, T2>, arg1: &T1, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::id<T1>(arg1);
        assert!(!0x2::table::contains<0x2::object::ID, bool>(&arg0.claimed, v0), 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.balance, arg0.airdrop_amount, arg2), 0x2::tx_context::sender(arg2));
        0x2::table::add<0x2::object::ID, bool>(&mut arg0.claimed, v0, true);
    }

    public entry fun claim_airdrop_receipt<T0, T1: key, T2: key>(arg0: &mut AirdropConfig<T0, T1, T2>, arg1: &T2, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!0x2::table::contains<0x2::object::ID, bool>(&arg0.claimed, arg2), 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.balance, arg0.airdrop_amount, arg3), 0x2::tx_context::sender(arg3));
        0x2::table::add<0x2::object::ID, bool>(&mut arg0.claimed, arg2, true);
    }

    public entry fun create_vault<T0, T1: key, T2>(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AirdropConfig<T0, T1, T2>{
            id             : 0x2::object::new(arg0),
            owner          : 0x2::tx_context::sender(arg0),
            balance        : 0x2::balance::zero<T0>(),
            claimed        : 0x2::table::new<0x2::object::ID, bool>(arg0),
            airdrop_amount : 1000000000000,
        };
        0x2::transfer::share_object<AirdropConfig<T0, T1, T2>>(v0);
    }

    public entry fun deposit_rewards<T0, T1: key, T2>(arg0: &mut AirdropConfig<T0, T1, T2>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg2), 0);
        0x2::coin::put<T0>(&mut arg0.balance, arg1);
    }

    public entry fun withdraw_rewards<T0, T1: key, T2>(arg0: &mut AirdropConfig<T0, T1, T2>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg2), 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.balance, arg1, arg2), 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

