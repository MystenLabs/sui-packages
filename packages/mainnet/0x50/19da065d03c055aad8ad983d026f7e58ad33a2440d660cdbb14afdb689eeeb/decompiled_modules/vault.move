module 0x5019da065d03c055aad8ad983d026f7e58ad33a2440d660cdbb14afdb689eeeb::vault {
    struct ManagerCap has key {
        id: 0x2::object::UID,
    }

    struct PT has drop {
        dummy_field: bool,
    }

    struct YT has drop {
        dummy_field: bool,
    }

    struct TOKEN<phantom T0, phantom T1> has drop {
        dummy_field: bool,
    }

    struct Vault<phantom T0> has key {
        id: 0x2::object::UID,
        created_epoch: u64,
        maturity_epoch: u64,
        vault_apy: u64,
        pools: vector<0x2::object::ID>,
        whitelist: vector<address>,
        holdings: 0x2::table::Table<u64, 0x3::staking_pool::StakedSui>,
        deposit_count: u64,
        pending_withdrawal: 0x2::balance::Balance<0x2::sui::SUI>,
        pt_supply: 0x2::balance::Supply<TOKEN<T0, PT>>,
        yt_supply: 0x2::balance::Supply<TOKEN<T0, YT>>,
        principal_balance: u64,
        debt_balance: u64,
        claim_enabled: bool,
        claim_table: 0x2::table::Table<u64, vector<address>>,
    }

    struct MintEvent has copy, drop {
        vault_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        input_amount: u64,
        pt_issued: u64,
        deposit_id: u64,
        asset_object_id: 0x2::object::ID,
        sender: address,
        epoch: u64,
        principal_balance: u64,
        debt_balance: u64,
        earning_balance: u64,
        pending_balance: u64,
    }

    struct RedeemEvent has copy, drop {
        vault_id: 0x2::object::ID,
        pt_burned: u64,
        sui_amount: u64,
        sender: address,
        epoch: u64,
        principal_balance: u64,
        debt_balance: u64,
        earning_balance: u64,
        pending_balance: u64,
    }

    struct NewVaultEvent has copy, drop {
        created_epoch: u64,
        maturity_epoch: u64,
        initial_apy: u64,
    }

    struct UpdateVaultApy has copy, drop {
        vault_id: 0x2::object::ID,
        vault_apy: u64,
        epoch: u64,
        principal_balance: u64,
        debt_balance: u64,
        earning_balance: u64,
        pending_balance: u64,
    }

    struct ClaimEvent has copy, drop {
        vault_id: 0x2::object::ID,
        sender: address,
        epoch: u64,
        claim_epoch: u64,
        input_amount: u64,
        output_amount: u64,
        is_pt: bool,
        principal_balance: u64,
        debt_balance: u64,
        earning_balance: u64,
        pending_balance: u64,
    }

    public entry fun add_pool<T0>(arg0: &mut Vault<T0>, arg1: &ManagerCap, arg2: 0x2::object::ID) {
        assert!(!0x1::vector::contains<0x2::object::ID>(&arg0.pools, &arg2), 3);
        0x1::vector::push_back<0x2::object::ID>(&mut arg0.pools, arg2);
    }

    public entry fun add_user<T0>(arg0: &mut Vault<T0>, arg1: &ManagerCap, arg2: address) {
        assert!(!0x1::vector::contains<address>(&arg0.whitelist, &arg2), 3);
        0x1::vector::push_back<address>(&mut arg0.whitelist, arg2);
    }

    public entry fun claim<T0>(arg0: &mut 0x3::sui_system::SuiSystemState, arg1: &mut Vault<T0>, arg2: &mut 0x5019da065d03c055aad8ad983d026f7e58ad33a2440d660cdbb14afdb689eeeb::amm::Global, arg3: &0x2::coin::Coin<TOKEN<T0, YT>>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.claim_enabled == true, 13);
        let v0 = find_claim_epoch<T0>(arg1, 0x2::tx_context::epoch(arg4));
        assert!(v0 > 1, 12);
        let v1 = total_claim_epoch<T0>(arg1);
        let v2 = vault_rewards<T0>(arg0, arg1, arg1.created_epoch + (v0 - 1) * 3);
        let v3 = arg1.debt_balance;
        let v4 = 0x2::coin::value<TOKEN<T0, YT>>(arg3);
        let v5 = yt_circulation<T0>(arg1, arg2);
        let v6 = if (v2 >= v3) {
            v2 - v3
        } else {
            0
        };
        assert!(v6 > 0, 15);
        if (arg1.maturity_epoch >= 0x2::tx_context::epoch(arg4)) {
            let v7 = 0x5019da065d03c055aad8ad983d026f7e58ad33a2440d660cdbb14afdb689eeeb::math::mul_div(v6 / (v1 - v0), v4, v5);
            let v8 = if (0x2::table::contains<u64, vector<address>>(&arg1.claim_table, v0)) {
                0x2::table::remove<u64, vector<address>>(&mut arg1.claim_table, v0)
            } else {
                0x1::vector::empty<address>()
            };
            let v9 = v8;
            let v10 = 0x2::tx_context::sender(arg4);
            assert!(0x1::vector::contains<address>(&v9, &v10) == false, 14);
            0x1::vector::push_back<address>(&mut v9, 0x2::tx_context::sender(arg4));
            0x2::table::add<u64, vector<address>>(&mut arg1.claim_table, v0, v9);
            mint_pt<T0>(arg1, v7, arg4);
            let v11 = ClaimEvent{
                vault_id          : 0x2::object::id<Vault<T0>>(arg1),
                sender            : 0x2::tx_context::sender(arg4),
                epoch             : 0x2::tx_context::epoch(arg4),
                claim_epoch       : v0,
                input_amount      : v4,
                output_amount     : v7,
                is_pt             : true,
                principal_balance : arg1.principal_balance,
                debt_balance      : arg1.debt_balance,
                earning_balance   : vault_rewards<T0>(arg0, arg1, 0x2::tx_context::epoch(arg4)),
                pending_balance   : 0x2::balance::value<0x2::sui::SUI>(&arg1.pending_withdrawal),
            };
            0x2::event::emit<ClaimEvent>(v11);
        } else {
            let v12 = 0x5019da065d03c055aad8ad983d026f7e58ad33a2440d660cdbb14afdb689eeeb::math::mul_div(v6 / 3, v4, v5);
            let v13 = if (0x2::table::contains<u64, vector<address>>(&arg1.claim_table, v0)) {
                0x2::table::remove<u64, vector<address>>(&mut arg1.claim_table, v0)
            } else {
                0x1::vector::empty<address>()
            };
            let v14 = v13;
            let v15 = 0x2::tx_context::sender(arg4);
            assert!(0x1::vector::contains<address>(&v14, &v15) == false, 14);
            0x1::vector::push_back<address>(&mut v14, 0x2::tx_context::sender(arg4));
            0x2::table::add<u64, vector<address>>(&mut arg1.claim_table, v0, v14);
            prepare_withdraw<T0>(arg0, arg1, v6, arg4);
            let v16 = 0x2::tx_context::sender(arg4);
            withdraw_sui<T0>(arg1, v12, v16, arg4);
            let v17 = ClaimEvent{
                vault_id          : 0x2::object::id<Vault<T0>>(arg1),
                sender            : 0x2::tx_context::sender(arg4),
                epoch             : 0x2::tx_context::epoch(arg4),
                claim_epoch       : v0,
                input_amount      : v4,
                output_amount     : v12,
                is_pt             : false,
                principal_balance : arg1.principal_balance,
                debt_balance      : arg1.debt_balance,
                earning_balance   : vault_rewards<T0>(arg0, arg1, 0x2::tx_context::epoch(arg4)),
                pending_balance   : 0x2::balance::value<0x2::sui::SUI>(&arg1.pending_withdrawal),
            };
            0x2::event::emit<ClaimEvent>(v17);
        };
    }

    public entry fun disable_claim<T0>(arg0: &mut Vault<T0>, arg1: &ManagerCap) {
        arg0.claim_enabled = false;
    }

    public entry fun enable_claim<T0>(arg0: &mut Vault<T0>, arg1: &ManagerCap) {
        arg0.claim_enabled = true;
    }

    fun find_claim_epoch<T0>(arg0: &Vault<T0>, arg1: u64) : u64 {
        0x2::math::divide_and_round_up(arg1 - arg0.created_epoch, 3)
    }

    fun future_pt<T0>(arg0: &Vault<T0>, arg1: u64, arg2: u64) : u64 {
        ((((arg0.maturity_epoch - arg1) as u128) * (arg0.vault_apy as u128) * (arg2 as u128) / 365000000000) as u64)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = ManagerCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<ManagerCap>(v0, 0x2::tx_context::sender(arg0));
    }

    fun locate_withdrawable_asset<T0>(arg0: &mut 0x3::sui_system::SuiSystemState, arg1: &mut Vault<T0>, arg2: u64, arg3: u64) : vector<u64> {
        let v0 = 0;
        let v1 = 0x1::vector::empty<u64>();
        let v2 = arg2 - 0x2::balance::value<0x2::sui::SUI>(&arg1.pending_withdrawal);
        while (v2 > 0) {
            if (0x2::table::contains<u64, 0x3::staking_pool::StakedSui>(&arg1.holdings, v0)) {
                let v3 = 0x2::table::borrow<u64, 0x3::staking_pool::StakedSui>(&arg1.holdings, v0);
                let v4 = 0x3::staking_pool::staked_sui_amount(v3) + 0x5019da065d03c055aad8ad983d026f7e58ad33a2440d660cdbb14afdb689eeeb::apy_reader::earnings_from_staked_sui(arg0, v3, arg3);
                0x1::vector::push_back<u64>(&mut v1, v0);
                let v5 = if (arg2 >= v4) {
                    arg2 - v4
                } else {
                    0
                };
                v2 = v5;
            };
            let v6 = v0 + 1;
            v0 = v6;
            if (v6 == arg1.deposit_count) {
                v2 = 0;
            };
        };
        v1
    }

    public entry fun mint<T0>(arg0: &mut 0x3::sui_system::SuiSystemState, arg1: &mut Vault<T0>, arg2: 0x3::staking_pool::StakedSui, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.maturity_epoch - 3 > 0x2::tx_context::epoch(arg3), 5);
        assert!(0x3::staking_pool::staked_sui_amount(&arg2) >= 1000000000, 6);
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(0x1::vector::contains<address>(&arg1.whitelist, &v0), 7);
        let v1 = 0x3::staking_pool::pool_id(&arg2);
        assert!(0x1::vector::contains<0x2::object::ID>(&arg1.pools, &v1), 8);
        let v2 = 0x2::object::id<Vault<T0>>(arg1);
        let v3 = 0x3::staking_pool::staked_sui_amount(&arg2);
        let v4 = receive_staked_sui<T0>(arg1, arg2);
        let v5 = future_pt<T0>(arg1, 0x2::tx_context::epoch(arg3), v3);
        arg1.principal_balance = arg1.principal_balance + v3;
        arg1.debt_balance = arg1.debt_balance + v5;
        let v6 = v3 + v5;
        mint_pt<T0>(arg1, v6, arg3);
        let v7 = MintEvent{
            vault_id          : 0x2::object::id<Vault<T0>>(arg1),
            pool_id           : v1,
            input_amount      : v3,
            pt_issued         : v6,
            deposit_id        : v4,
            asset_object_id   : v2,
            sender            : v0,
            epoch             : 0x2::tx_context::epoch(arg3),
            principal_balance : arg1.principal_balance,
            debt_balance      : arg1.debt_balance,
            earning_balance   : vault_rewards<T0>(arg0, arg1, 0x2::tx_context::epoch(arg3)),
            pending_balance   : 0x2::balance::value<0x2::sui::SUI>(&arg1.pending_withdrawal),
        };
        0x2::event::emit<MintEvent>(v7);
    }

    fun mint_pt<T0>(arg0: &mut Vault<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<TOKEN<T0, PT>>>(0x2::coin::from_balance<TOKEN<T0, PT>>(0x2::balance::increase_supply<TOKEN<T0, PT>>(&mut arg0.pt_supply, arg1), arg2), 0x2::tx_context::sender(arg2));
    }

    public entry fun new_vault<T0>(arg0: &mut ManagerCap, arg1: u64, arg2: u64, arg3: &mut 0x5019da065d03c055aad8ad983d026f7e58ad33a2440d660cdbb14afdb689eeeb::amm::Global, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 > 0x2::tx_context::epoch(arg5), 2);
        let v0 = TOKEN<T0, PT>{dummy_field: false};
        let v1 = TOKEN<T0, YT>{dummy_field: false};
        let v2 = 0x2::balance::create_supply<TOKEN<T0, YT>>(v1);
        let v3 = 0x5019da065d03c055aad8ad983d026f7e58ad33a2440d660cdbb14afdb689eeeb::amm::is_order<0x2::sui::SUI, TOKEN<T0, YT>>();
        if (!0x5019da065d03c055aad8ad983d026f7e58ad33a2440d660cdbb14afdb689eeeb::amm::has_registered<0x2::sui::SUI, TOKEN<T0, YT>>(arg3)) {
            0x5019da065d03c055aad8ad983d026f7e58ad33a2440d660cdbb14afdb689eeeb::amm::register_pool<0x2::sui::SUI, TOKEN<T0, YT>>(arg3, v3);
        };
        let (v4, _) = 0x5019da065d03c055aad8ad983d026f7e58ad33a2440d660cdbb14afdb689eeeb::amm::add_liquidity<0x2::sui::SUI, TOKEN<T0, YT>>(0x5019da065d03c055aad8ad983d026f7e58ad33a2440d660cdbb14afdb689eeeb::amm::get_mut_pool<0x2::sui::SUI, TOKEN<T0, YT>>(arg3, v3), arg4, 1, 0x2::coin::from_balance<TOKEN<T0, YT>>(0x2::balance::increase_supply<TOKEN<T0, YT>>(&mut v2, 100000000000000000), arg5), 1, v3, arg5);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x5019da065d03c055aad8ad983d026f7e58ad33a2440d660cdbb14afdb689eeeb::amm::LP<0x2::sui::SUI, TOKEN<T0, YT>>>>(v4, 0x2::tx_context::sender(arg5));
        let v6 = Vault<T0>{
            id                 : 0x2::object::new(arg5),
            created_epoch      : 0x2::tx_context::epoch(arg5),
            maturity_epoch     : arg2,
            vault_apy          : arg1,
            pools              : 0x1::vector::empty<0x2::object::ID>(),
            whitelist          : 0x1::vector::empty<address>(),
            holdings           : 0x2::table::new<u64, 0x3::staking_pool::StakedSui>(arg5),
            deposit_count      : 0,
            pending_withdrawal : 0x2::balance::zero<0x2::sui::SUI>(),
            pt_supply          : 0x2::balance::create_supply<TOKEN<T0, PT>>(v0),
            yt_supply          : v2,
            principal_balance  : 0,
            debt_balance       : 0,
            claim_enabled      : true,
            claim_table        : 0x2::table::new<u64, vector<address>>(arg5),
        };
        0x2::transfer::share_object<Vault<T0>>(v6);
        let v7 = NewVaultEvent{
            created_epoch  : 0x2::tx_context::epoch(arg5),
            maturity_epoch : arg2,
            initial_apy    : arg1,
        };
        0x2::event::emit<NewVaultEvent>(v7);
    }

    fun prepare_withdraw<T0>(arg0: &mut 0x3::sui_system::SuiSystemState, arg1: &mut Vault<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        if (arg2 > 0x2::balance::value<0x2::sui::SUI>(&arg1.pending_withdrawal)) {
            let v0 = locate_withdrawable_asset<T0>(arg0, arg1, arg2, 0x2::tx_context::epoch(arg3));
            let v1 = unstake_staked_sui<T0>(arg0, arg1, v0, arg3);
            0x2::balance::join<0x2::sui::SUI>(&mut arg1.pending_withdrawal, v1);
        };
    }

    fun receive_staked_sui<T0>(arg0: &mut Vault<T0>, arg1: 0x3::staking_pool::StakedSui) : u64 {
        let v0 = arg0.deposit_count;
        0x2::table::add<u64, 0x3::staking_pool::StakedSui>(&mut arg0.holdings, v0, arg1);
        arg0.deposit_count = arg0.deposit_count + 1;
        v0
    }

    public entry fun redeem<T0>(arg0: &mut 0x3::sui_system::SuiSystemState, arg1: &mut Vault<T0>, arg2: 0x2::coin::Coin<TOKEN<T0, PT>>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::epoch(arg3) > arg1.maturity_epoch, 9);
        assert!(0x2::coin::value<TOKEN<T0, PT>>(&arg2) >= 1000000000, 6);
        let v0 = 0x2::coin::value<TOKEN<T0, PT>>(&arg2);
        prepare_withdraw<T0>(arg0, arg1, v0, arg3);
        let v1 = 0x2::tx_context::sender(arg3);
        withdraw_sui<T0>(arg1, v0, v1, arg3);
        let v2 = RedeemEvent{
            vault_id          : 0x2::object::id<Vault<T0>>(arg1),
            pt_burned         : 0x2::balance::decrease_supply<TOKEN<T0, PT>>(&mut arg1.pt_supply, 0x2::coin::into_balance<TOKEN<T0, PT>>(arg2)),
            sui_amount        : v0,
            sender            : 0x2::tx_context::sender(arg3),
            epoch             : 0x2::tx_context::epoch(arg3),
            principal_balance : arg1.principal_balance,
            debt_balance      : arg1.debt_balance,
            earning_balance   : vault_rewards<T0>(arg0, arg1, 0x2::tx_context::epoch(arg3)),
            pending_balance   : 0x2::balance::value<0x2::sui::SUI>(&arg1.pending_withdrawal),
        };
        0x2::event::emit<RedeemEvent>(v2);
    }

    public entry fun remove_pool<T0>(arg0: &mut Vault<T0>, arg1: &ManagerCap, arg2: 0x2::object::ID) {
        let (v0, v1) = 0x1::vector::index_of<0x2::object::ID>(&arg0.pools, &arg2);
        assert!(v0, 4);
        0x1::vector::remove<0x2::object::ID>(&mut arg0.pools, v1);
    }

    public entry fun remove_user<T0>(arg0: &mut Vault<T0>, arg1: &ManagerCap, arg2: address) {
        let (v0, v1) = 0x1::vector::index_of<address>(&arg0.whitelist, &arg2);
        assert!(v0, 4);
        0x1::vector::remove<address>(&mut arg0.whitelist, v1);
    }

    public entry fun topup<T0>(arg0: &mut Vault<T0>, arg1: &ManagerCap, arg2: 0x2::coin::Coin<0x2::sui::SUI>) {
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.pending_withdrawal, 0x2::coin::into_balance<0x2::sui::SUI>(arg2));
    }

    fun total_claim_epoch<T0>(arg0: &Vault<T0>) : u64 {
        0x2::math::divide_and_round_up(arg0.maturity_epoch - arg0.created_epoch, 3)
    }

    fun unstake_staked_sui<T0>(arg0: &mut 0x3::sui_system::SuiSystemState, arg1: &mut Vault<T0>, arg2: vector<u64>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<0x2::sui::SUI> {
        let v0 = 0x2::balance::zero<0x2::sui::SUI>();
        while (0x1::vector::length<u64>(&arg2) > 0) {
            let v1 = 0x2::table::remove<u64, 0x3::staking_pool::StakedSui>(&mut arg1.holdings, 0x1::vector::pop_back<u64>(&mut arg2));
            let v2 = 0x3::staking_pool::staked_sui_amount(&v1);
            let v3 = 0x3::sui_system::request_withdraw_stake_non_entry(arg0, v1, arg3);
            let v4 = if (0x2::balance::value<0x2::sui::SUI>(&v3) >= v2) {
                0x2::balance::value<0x2::sui::SUI>(&v3) - v2
            } else {
                0
            };
            0x2::balance::join<0x2::sui::SUI>(&mut v0, v3);
            arg1.principal_balance = arg1.principal_balance - v2;
            let v5 = if (arg1.debt_balance >= v4) {
                arg1.debt_balance - v4
            } else {
                0
            };
            arg1.debt_balance = v5;
        };
        v0
    }

    public entry fun update_vault_apy<T0>(arg0: &mut 0x3::sui_system::SuiSystemState, arg1: &mut Vault<T0>, arg2: &ManagerCap, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        arg1.vault_apy = arg3;
        let v0 = UpdateVaultApy{
            vault_id          : 0x2::object::id<Vault<T0>>(arg1),
            vault_apy         : arg3,
            epoch             : 0x2::tx_context::epoch(arg4),
            principal_balance : arg1.principal_balance,
            debt_balance      : arg1.debt_balance,
            earning_balance   : vault_rewards<T0>(arg0, arg1, 0x2::tx_context::epoch(arg4)),
            pending_balance   : 0x2::balance::value<0x2::sui::SUI>(&arg1.pending_withdrawal),
        };
        0x2::event::emit<UpdateVaultApy>(v0);
    }

    public fun vault_apy<T0>(arg0: &Vault<T0>) : u64 {
        arg0.vault_apy
    }

    public fun vault_debts<T0>(arg0: &Vault<T0>) : u64 {
        arg0.debt_balance
    }

    public fun vault_pending<T0>(arg0: &Vault<T0>) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.pending_withdrawal)
    }

    public fun vault_principals<T0>(arg0: &Vault<T0>) : u64 {
        arg0.principal_balance
    }

    public fun vault_rewards<T0>(arg0: &mut 0x3::sui_system::SuiSystemState, arg1: &Vault<T0>, arg2: u64) : u64 {
        let v0 = 0;
        let v1 = 0;
        while (v0 < 0x2::table::length<u64, 0x3::staking_pool::StakedSui>(&arg1.holdings)) {
            if (0x2::table::contains<u64, 0x3::staking_pool::StakedSui>(&arg1.holdings, v0)) {
                let v2 = 0x2::table::borrow<u64, 0x3::staking_pool::StakedSui>(&arg1.holdings, v0);
                if (arg2 > 0x3::staking_pool::stake_activation_epoch(v2)) {
                    v1 = v1 + 0x5019da065d03c055aad8ad983d026f7e58ad33a2440d660cdbb14afdb689eeeb::apy_reader::earnings_from_staked_sui(arg0, v2, arg2);
                };
            };
            v0 = v0 + 1;
        };
        v1
    }

    fun withdraw_sui<T0>(arg0: &mut Vault<T0>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.pending_withdrawal) >= arg1, 10);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.pending_withdrawal, arg1), arg3), arg2);
    }

    fun yt_circulation<T0>(arg0: &mut Vault<T0>, arg1: &mut 0x5019da065d03c055aad8ad983d026f7e58ad33a2440d660cdbb14afdb689eeeb::amm::Global) : u64 {
        0x2::balance::supply_value<TOKEN<T0, YT>>(&arg0.yt_supply) - 0x5019da065d03c055aad8ad983d026f7e58ad33a2440d660cdbb14afdb689eeeb::amm::balance_y<0x2::sui::SUI, TOKEN<T0, YT>>(0x5019da065d03c055aad8ad983d026f7e58ad33a2440d660cdbb14afdb689eeeb::amm::get_mut_pool<0x2::sui::SUI, TOKEN<T0, YT>>(arg1, 0x5019da065d03c055aad8ad983d026f7e58ad33a2440d660cdbb14afdb689eeeb::amm::is_order<0x2::sui::SUI, TOKEN<T0, YT>>()))
    }

    // decompiled from Move bytecode v6
}

