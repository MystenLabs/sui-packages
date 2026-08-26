module 0xf01174d560a525a8b0635b5713ba334e26d7cd6f221701e785c28e46febf6fd4::priority_fee_vault {
    struct PriorityFeeVault has key {
        id: 0x2::object::UID,
    }

    struct PriorityFeeVaultInnerV1 has store {
        sui_balance: 0x2::balance::Balance<0x2::sui::SUI>,
        us_balance: 0x2::balance::Balance<0xee962a61432231c2ede6946515beb02290cb516ad087bb06a731e922b2a5f57a::us::US>,
        exchange_rate_million_mists_us: u64,
        total_share: u64,
        leader_accounts: 0x2::vec_map::VecMap<0x2::object::ID, PriorityFeeAccount>,
    }

    struct PriorityFeeAccount has copy, drop, store {
        share: u64,
    }

    struct PriorityFeeVaultOwnerCap has store, key {
        id: 0x2::object::UID,
        vault: 0x2::object::ID,
    }

    struct PriorityFeeDeposit has key {
        id: 0x2::object::UID,
        amount: 0x2::balance::Balance<0x2::sui::SUI>,
        leader_cap_id: 0x2::object::ID,
    }

    struct PriorityFeeDepositCreatedEvent has copy, drop {
        vault: 0x2::object::ID,
        deposit_id: 0x2::object::ID,
        leader_cap_id: 0x2::object::ID,
        amount: u64,
    }

    struct PriorityFeeShareChange has copy, drop {
        leader_cap_id: 0x2::object::ID,
        share_delta: u64,
    }

    struct PriorityFeeSharesCollectedEvent has copy, drop {
        vault: 0x2::object::ID,
        deposit_count: u64,
        changes: vector<PriorityFeeShareChange>,
        total_share_delta: u64,
    }

    struct PriorityFeeWithdrawnEvent has copy, drop {
        vault: 0x2::object::ID,
        leader_cap_id: 0x2::object::ID,
        share_to_withdraw: u64,
        us_out: u64,
        us_refunded: u64,
    }

    struct PriorityFeeSwapEvent has copy, drop {
        vault: 0x2::object::ID,
        us_in: u64,
        us_refunded: u64,
        sui_out: u64,
    }

    struct PriorityFeeVaultConfiguredEvent has copy, drop {
        vault: 0x2::object::ID,
        exchange_rate_million_mists_us: u64,
    }

    public(friend) fun new(arg0: &mut 0x2::tx_context::TxContext) : (PriorityFeeVault, PriorityFeeVaultOwnerCap) {
        let v0 = PriorityFeeVault{id: 0x2::object::new(arg0)};
        let v1 = PriorityFeeVaultInnerV1{
            sui_balance                    : 0x2::balance::zero<0x2::sui::SUI>(),
            us_balance                     : 0x2::balance::zero<0xee962a61432231c2ede6946515beb02290cb516ad087bb06a731e922b2a5f57a::us::US>(),
            exchange_rate_million_mists_us : 0,
            total_share                    : 0,
            leader_accounts                : 0x2::vec_map::empty<0x2::object::ID, PriorityFeeAccount>(),
        };
        0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::object_state::add<0xf01174d560a525a8b0635b5713ba334e26d7cd6f221701e785c28e46febf6fd4::era::V1, PriorityFeeVaultInnerV1>(&mut v0.id, 0xf01174d560a525a8b0635b5713ba334e26d7cd6f221701e785c28e46febf6fd4::era::v1(), v1);
        let v2 = PriorityFeeVaultOwnerCap{
            id    : 0x2::object::new(arg0),
            vault : 0x2::object::id<PriorityFeeVault>(&v0),
        };
        (v0, v2)
    }

    fun accrue_for_leader(arg0: &mut PriorityFeeVault, arg1: 0x2::object::ID, arg2: u64) {
        let v0 = load_v1_mut(arg0);
        if (0x2::vec_map::contains<0x2::object::ID, PriorityFeeAccount>(&v0.leader_accounts, &arg1)) {
            let v1 = 0x2::vec_map::get_mut<0x2::object::ID, PriorityFeeAccount>(&mut v0.leader_accounts, &arg1);
            assert!((v1.share as u128) + (arg2 as u128) <= 18446744073709551615, 13906835883741020171);
            v1.share = v1.share + arg2;
        } else {
            let v2 = PriorityFeeAccount{share: arg2};
            0x2::vec_map::insert<0x2::object::ID, PriorityFeeAccount>(&mut v0.leader_accounts, arg1, v2);
        };
    }

    public fun collect_deposits(arg0: &mut PriorityFeeVault, arg1: &0xf01174d560a525a8b0635b5713ba334e26d7cd6f221701e785c28e46febf6fd4::leader::LeaderRegistry, arg2: vector<0x2::transfer::Receiving<PriorityFeeDeposit>>) {
        let v0 = 0x1::vector::length<0x2::transfer::Receiving<PriorityFeeDeposit>>(&arg2);
        assert!(v0 > 0, 13906834934553378829);
        let v1 = 0x2::object::id<PriorityFeeVault>(arg0);
        0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::object_state::assert_witness<0xf01174d560a525a8b0635b5713ba334e26d7cd6f221701e785c28e46febf6fd4::era::V1>(&arg0.id);
        let v2 = 0;
        let v3 = 0x2::vec_map::empty<0x2::object::ID, u64>();
        let v4 = 0;
        while (v4 < 0x1::vector::length<0x2::transfer::Receiving<PriorityFeeDeposit>>(&arg2)) {
            let PriorityFeeDeposit {
                id            : v5,
                amount        : v6,
                leader_cap_id : v7,
            } = 0x2::transfer::receive<PriorityFeeDeposit>(&mut arg0.id, 0x1::vector::pop_back<0x2::transfer::Receiving<PriorityFeeDeposit>>(&mut arg2));
            let v8 = v7;
            let v9 = v6;
            0x2::object::delete(v5);
            let v10 = 0x2::balance::value<0x2::sui::SUI>(&v9);
            assert!(v10 > 0, 13906834994682134529);
            0xf01174d560a525a8b0635b5713ba334e26d7cd6f221701e785c28e46febf6fd4::leader::assert_registered(arg1, v8);
            assert!((v2 as u128) + (v10 as u128) <= 18446744073709551615, 13906835011862659083);
            v2 = v2 + v10;
            if (0x2::vec_map::contains<0x2::object::ID, u64>(&v3, &v8)) {
                let v11 = 0x2::vec_map::get_mut<0x2::object::ID, u64>(&mut v3, &v8);
                assert!((*v11 as u128) + (v10 as u128) <= 18446744073709551615, 13906835046222397451);
                *v11 = *v11 + v10;
            } else {
                0x2::vec_map::insert<0x2::object::ID, u64>(&mut v3, v8, v10);
            };
            let v12 = load_v1_mut(arg0);
            assert!((v12.total_share as u128) + (v10 as u128) <= 18446744073709551615, 13906835089172070411);
            0x2::balance::join<0x2::sui::SUI>(&mut v12.sui_balance, v9);
            v12.total_share = v12.total_share + v10;
            accrue_for_leader(arg0, v8, v10);
            v4 = v4 + 1;
        };
        0x1::vector::destroy_empty<0x2::transfer::Receiving<PriorityFeeDeposit>>(arg2);
        let (v13, v14) = 0x2::vec_map::into_keys_values<0x2::object::ID, u64>(v3);
        let v15 = v14;
        let v16 = v13;
        let v17 = 0x1::vector::empty<PriorityFeeShareChange>();
        let v18 = 0;
        while (v18 < 0x1::vector::length<0x2::object::ID>(&v16)) {
            let v19 = PriorityFeeShareChange{
                leader_cap_id : *0x1::vector::borrow<0x2::object::ID>(&v16, v18),
                share_delta   : *0x1::vector::borrow<u64>(&v15, v18),
            };
            0x1::vector::push_back<PriorityFeeShareChange>(&mut v17, v19);
            v18 = v18 + 1;
        };
        let v20 = PriorityFeeSharesCollectedEvent{
            vault             : v1,
            deposit_count     : v0,
            changes           : v17,
            total_share_delta : v2,
        };
        0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::event::emit<PriorityFeeSharesCollectedEvent>(v20);
    }

    public fun configure(arg0: &mut PriorityFeeVault, arg1: &PriorityFeeVaultOwnerCap, arg2: u64) {
        let v0 = 0x2::object::id<PriorityFeeVault>(arg0);
        assert!(arg1.vault == v0, 13906835634632654855);
        assert!(arg2 > 0, 13906835638927360003);
        load_v1_mut(arg0).exchange_rate_million_mists_us = arg2;
        let v1 = PriorityFeeVaultConfiguredEvent{
            vault                          : v0,
            exchange_rate_million_mists_us : arg2,
        };
        0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::event::emit<PriorityFeeVaultConfiguredEvent>(v1);
    }

    public fun create_deposit(arg0: &PriorityFeeVault, arg1: 0x2::balance::Balance<0x2::sui::SUI>, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg1);
        if (v0 == 0) {
            0x2::balance::destroy_zero<0x2::sui::SUI>(arg1);
            return
        };
        let v1 = 0x2::object::id<PriorityFeeVault>(arg0);
        let v2 = PriorityFeeDeposit{
            id            : 0x2::object::new(arg3),
            amount        : arg1,
            leader_cap_id : arg2,
        };
        let v3 = PriorityFeeDepositCreatedEvent{
            vault         : v1,
            deposit_id    : 0x2::object::id<PriorityFeeDeposit>(&v2),
            leader_cap_id : arg2,
            amount        : v0,
        };
        0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::event::emit<PriorityFeeDepositCreatedEvent>(v3);
        0x2::transfer::transfer<PriorityFeeDeposit>(v2, 0x2::object::id_to_address(&v1));
    }

    public fun exchange_rate_million_mists_us(arg0: &PriorityFeeVault) : u64 {
        load_v1(arg0).exchange_rate_million_mists_us
    }

    public(friend) fun id_mut_for_transition(arg0: &mut PriorityFeeVault) : &mut 0x2::object::UID {
        &mut arg0.id
    }

    public fun leader_account(arg0: &PriorityFeeVault, arg1: 0x2::object::ID) : u64 {
        let v0 = load_v1(arg0);
        if (!0x2::vec_map::contains<0x2::object::ID, PriorityFeeAccount>(&v0.leader_accounts, &arg1)) {
            return 0
        };
        0x2::vec_map::get<0x2::object::ID, PriorityFeeAccount>(&v0.leader_accounts, &arg1).share
    }

    fun load_v1(arg0: &PriorityFeeVault) : &PriorityFeeVaultInnerV1 {
        0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::object_state::inner<PriorityFeeVaultInnerV1>(&arg0.id)
    }

    fun load_v1_mut(arg0: &mut PriorityFeeVault) : &mut PriorityFeeVaultInnerV1 {
        0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::object_state::inner_mut<0xf01174d560a525a8b0635b5713ba334e26d7cd6f221701e785c28e46febf6fd4::era::V1, PriorityFeeVaultInnerV1>(&mut arg0.id)
    }

    public fun quote_swap_us_for_sui(arg0: &PriorityFeeVault, arg1: u64) : u64 {
        let v0 = load_v1(arg0);
        if (v0.exchange_rate_million_mists_us == 0) {
            return 0
        };
        let v1 = (0x2::balance::value<0x2::sui::SUI>(&v0.sui_balance) as u128);
        let v2 = (arg1 as u128) * 1000000 / (v0.exchange_rate_million_mists_us as u128);
        let v3 = if (v1 < v2) {
            v1
        } else {
            v2
        };
        assert!(v3 <= 18446744073709551615, 13906835849381281803);
        (v3 as u64)
    }

    public(friend) fun send_owner_cap_to_sender(arg0: PriorityFeeVaultOwnerCap, arg1: &0x2::tx_context::TxContext) {
        0x2::transfer::public_party_transfer<PriorityFeeVaultOwnerCap>(arg0, 0x2::party::single_owner(0x2::tx_context::sender(arg1)));
    }

    public(friend) fun share(arg0: PriorityFeeVault) {
        0x2::transfer::share_object<PriorityFeeVault>(arg0);
    }

    public fun sui_balance(arg0: &PriorityFeeVault) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&load_v1(arg0).sui_balance)
    }

    public fun swap_us_for_sui(arg0: &mut PriorityFeeVault, arg1: 0x2::coin::Coin<0xee962a61432231c2ede6946515beb02290cb516ad087bb06a731e922b2a5f57a::us::US>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<0xee962a61432231c2ede6946515beb02290cb516ad087bb06a731e922b2a5f57a::us::US>) {
        let v0 = 0x2::object::id<PriorityFeeVault>(arg0);
        let v1 = 0x2::coin::into_balance<0xee962a61432231c2ede6946515beb02290cb516ad087bb06a731e922b2a5f57a::us::US>(arg1);
        let v2 = 0x2::balance::value<0xee962a61432231c2ede6946515beb02290cb516ad087bb06a731e922b2a5f57a::us::US>(&v1);
        assert!(v2 > 0, 13906835235200565253);
        let v3 = load_v1(arg0).exchange_rate_million_mists_us;
        assert!(v3 > 0, 13906835243790368771);
        let v4 = quote_swap_us_for_sui(arg0, v2);
        assert!(v4 > 0, 13906835260970369029);
        assert!(v4 >= arg2, 13906835265265598473);
        let v5 = (v4 as u128) * (v3 as u128);
        let v6 = v5 / 1000000;
        let v7 = v6;
        if (v5 % 1000000 > 0) {
            v7 = v6 + 1;
        };
        assert!(v7 <= 18446744073709551615, 13906835295330500619);
        let v8 = load_v1_mut(arg0);
        0x2::balance::join<0xee962a61432231c2ede6946515beb02290cb516ad087bb06a731e922b2a5f57a::us::US>(&mut v8.us_balance, 0x2::balance::split<0xee962a61432231c2ede6946515beb02290cb516ad087bb06a731e922b2a5f57a::us::US>(&mut v1, (v7 as u64)));
        let v9 = PriorityFeeSwapEvent{
            vault       : v0,
            us_in       : v2,
            us_refunded : 0x2::balance::value<0xee962a61432231c2ede6946515beb02290cb516ad087bb06a731e922b2a5f57a::us::US>(&v1),
            sui_out     : v4,
        };
        0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::event::emit<PriorityFeeSwapEvent>(v9);
        (0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut v8.sui_balance, v4), arg3), 0x2::coin::from_balance<0xee962a61432231c2ede6946515beb02290cb516ad087bb06a731e922b2a5f57a::us::US>(v1, arg3))
    }

    public fun total_share(arg0: &PriorityFeeVault) : u64 {
        load_v1(arg0).total_share
    }

    public fun us_balance(arg0: &PriorityFeeVault) : u64 {
        0x2::balance::value<0xee962a61432231c2ede6946515beb02290cb516ad087bb06a731e922b2a5f57a::us::US>(&load_v1(arg0).us_balance)
    }

    public fun withdraw_priority_fee(arg0: &mut PriorityFeeVault, arg1: &0xf01174d560a525a8b0635b5713ba334e26d7cd6f221701e785c28e46febf6fd4::leader::LeaderRegistry, arg2: &0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::owner_cap::CloneableOwnerCap<0xf01174d560a525a8b0635b5713ba334e26d7cd6f221701e785c28e46febf6fd4::leader_cap::OverNetwork>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xee962a61432231c2ede6946515beb02290cb516ad087bb06a731e922b2a5f57a::us::US> {
        let v0 = 0x2::object::id<PriorityFeeVault>(arg0);
        let v1 = 0x2::object::id<0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::owner_cap::CloneableOwnerCap<0xf01174d560a525a8b0635b5713ba334e26d7cd6f221701e785c28e46febf6fd4::leader_cap::OverNetwork>>(arg2);
        0xf01174d560a525a8b0635b5713ba334e26d7cd6f221701e785c28e46febf6fd4::leader::assert_current_leader_cap(arg1, arg2);
        let v2 = load_v1_mut(arg0);
        assert!(0x2::balance::value<0x2::sui::SUI>(&v2.sui_balance) == 0, 13906835432768798721);
        assert!(v2.total_share > 0, 13906835437063766017);
        assert!(0x2::vec_map::contains<0x2::object::ID, PriorityFeeAccount>(&v2.leader_accounts, &v1), 13906835441358733313);
        let v3 = 0x2::vec_map::get<0x2::object::ID, PriorityFeeAccount>(&v2.leader_accounts, &v1);
        assert!(arg3 > 0, 13906835454243635201);
        assert!(arg3 <= v3.share, 13906835458538602497);
        let v4 = 0x2::balance::value<0xee962a61432231c2ede6946515beb02290cb516ad087bb06a731e922b2a5f57a::us::US>(&v2.us_balance);
        assert!(v4 > 0, 13906835471423504385);
        let v5 = if (arg3 == v2.total_share) {
            v4
        } else {
            let v6 = (((v4 as u128) * (arg3 as u128) / (v2.total_share as u128)) as u64);
            assert!(v6 > 0, 13906835505783242753);
            v6
        };
        v2.total_share = v2.total_share - arg3;
        if (arg3 == v3.share) {
            let (_, _) = 0x2::vec_map::remove<0x2::object::ID, PriorityFeeAccount>(&mut v2.leader_accounts, &v1);
        } else {
            let v9 = 0x2::vec_map::get_mut<0x2::object::ID, PriorityFeeAccount>(&mut v2.leader_accounts, &v1);
            v9.share = v9.share - arg3;
        };
        let v10 = PriorityFeeWithdrawnEvent{
            vault             : v0,
            leader_cap_id     : v1,
            share_to_withdraw : arg3,
            us_out            : v5,
            us_refunded       : v4 - v5,
        };
        0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::event::emit<PriorityFeeWithdrawnEvent>(v10);
        0x2::coin::from_balance<0xee962a61432231c2ede6946515beb02290cb516ad087bb06a731e922b2a5f57a::us::US>(0x2::balance::split<0xee962a61432231c2ede6946515beb02290cb516ad087bb06a731e922b2a5f57a::us::US>(&mut v2.us_balance, v5), arg4)
    }

    // decompiled from Move bytecode v7
}

