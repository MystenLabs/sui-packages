module 0x6c0798e31f86d7afc87c7c4582525c6c7f8fcf4244a08324388720fbd8918848::stablecoin_vault {
    struct STABLECOIN_VAULT has drop {
        dummy_field: bool,
    }

    struct StakeRecord has copy, drop, store {
        id: 0x2::object::ID,
        user: address,
        ausd_amount: u64,
        timestamp: u64,
        is_active: bool,
    }

    struct Vault<phantom T0> has store, key {
        id: 0x2::object::UID,
        registry_id: 0x2::object::ID,
        staked_balance: 0x2::balance::Balance<T0>,
        total_ausd_minted: u64,
        user_stakes: 0x2::table::Table<address, u64>,
        stake_records: 0x2::table::Table<0x2::object::ID, StakeRecord>,
        user_stake_ids: 0x2::table::Table<address, vector<0x2::object::ID>>,
        next_stake_id: u64,
        total_user_staked: u64,
        redemption_fee: u64,
        is_paused: bool,
        token_decimals: u8,
    }

    struct VaultRegistry has key {
        id: 0x2::object::UID,
        governance_registry_id: 0x2::object::ID,
        ausd_pool: 0x2::balance::Balance<0xd5dcd0e791949074b70af25dd6b0c2e121adcfa8a062a779846bf1dd5e0f4b9a::ausd::AUSD>,
        total_ausd_distributed: u64,
        total_redemption_fee: u64,
    }

    struct StakeEvent has copy, drop {
        user: address,
        token_type: 0x1::string::String,
        amount: u64,
        ausd_minted: u64,
        price_used: u64,
    }

    struct RedeemEvent has copy, drop {
        user: address,
        token_type: 0x1::string::String,
        amount: u64,
        ausd_recycling: u64,
        redemption_fee: u64,
        price_used: u64,
    }

    struct DepositEvent has copy, drop {
        depositor: address,
        token_type: 0x1::string::String,
        amount: u64,
    }

    struct WithdrawEvent has copy, drop {
        recipient: address,
        token_type: 0x1::string::String,
        amount: u64,
    }

    struct VaultPauseEvent has copy, drop {
        vault_id: 0x2::object::ID,
        is_paused: bool,
        admin: address,
    }

    fun calculate_average_discount_rate<T0>(arg0: &Vault<T0>, arg1: address, arg2: &0x2::clock::Clock) : u128 {
        let v0 = get_user_stake_records<T0>(arg0, arg1);
        let v1 = 0x1::vector::length<StakeRecord>(&v0);
        if (v1 == 0) {
            return 0
        };
        let v2 = 0x2::clock::timestamp_ms(arg2);
        let v3 = 0;
        let v4 = 0;
        let v5 = 0;
        while (v5 < v1) {
            let v6 = 0x1::vector::borrow<StakeRecord>(&v0, v5);
            let v7 = v6.ausd_amount;
            let v8 = v6.timestamp;
            let v9 = if (v2 >= v8) {
                v2 - v8
            } else {
                0
            };
            v3 = v3 + (v7 as u256) * (100000000 as u256) * (calculate_discount_rate(v9 / 86400000) as u256);
            v4 = v4 + (v7 as u128);
            v5 = v5 + 1;
        };
        if (v4 == 0) {
            return 0
        };
        let v10 = v3 / (v4 as u256) * (100000000 as u256);
        if (v10 > 340282366920938463463374607431768211455) {
            340282366920938463463374607431768211455
        } else {
            (v10 as u128)
        }
    }

    fun calculate_base_fee<T0>(arg0: &Vault<T0>, arg1: u64) : u64 {
        assert!(arg1 > 0, 5);
        let v0 = 0x2::balance::value<T0>(&arg0.staked_balance);
        assert!(v0 >= arg1, 8);
        let v1 = v0 - arg1;
        let v2 = 0x1a48417b612d55fda094ddc15928fc856a2235f6ea718788929298bd1b321b92::math_utils::safe_mul_u64(arg0.total_user_staked, 20) / 100;
        if (v1 > v2) {
            return 10
        };
        if (v2 == 0) {
            return 100
        };
        let v3 = 0x1a48417b612d55fda094ddc15928fc856a2235f6ea718788929298bd1b321b92::math_utils::safe_mul_u64(v1, 10000) / v2;
        let v4 = v3;
        if (v3 > 10000) {
            v4 = 10000;
        };
        let v5 = 100 - 0x1a48417b612d55fda094ddc15928fc856a2235f6ea718788929298bd1b321b92::math_utils::safe_mul_u64(100 - 10, v4) / 10000;
        if (v5 < 10) {
            10
        } else {
            v5
        }
    }

    fun calculate_discount_rate(arg0: u64) : u128 {
        if (arg0 <= 1) {
            200000000
        } else if (arg0 <= 7) {
            100000000
        } else if (arg0 <= 30) {
            80000000
        } else if (arg0 <= 60) {
            70000000
        } else if (arg0 <= 90) {
            60000000
        } else if (arg0 <= 180) {
            50000000
        } else if (arg0 <= 360) {
            40000000
        } else if (arg0 <= 720) {
            30000000
        } else if (arg0 <= 1440) {
            20000000
        } else {
            10000000
        }
    }

    public fun calculate_redemption_fee<T0>(arg0: &Vault<T0>, arg1: address, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock) : u64 {
        assert!(arg2 > 0, 5);
        ((0x1a48417b612d55fda094ddc15928fc856a2235f6ea718788929298bd1b321b92::math_utils::safe_mul_u128(0x1a48417b612d55fda094ddc15928fc856a2235f6ea718788929298bd1b321b92::math_utils::safe_mul_u128((arg2 as u128), (calculate_base_fee<T0>(arg0, arg3) as u128)), calculate_average_discount_rate<T0>(arg0, arg1, arg4)) / 0x1a48417b612d55fda094ddc15928fc856a2235f6ea718788929298bd1b321b92::math_utils::safe_mul_u128((10000 as u128), 100000000)) as u64) + 1000000
    }

    public fun convert_ausd_to_stablecoin<T0>(arg0: &Vault<T0>, arg1: u64) : u64 {
        assert!(arg1 > 0, 5);
        let v0 = arg0.token_decimals;
        let v1 = 6;
        if (v0 == v1) {
            arg1
        } else if (v0 > v1) {
            0x1a48417b612d55fda094ddc15928fc856a2235f6ea718788929298bd1b321b92::math_utils::safe_mul_u64(arg1, (0x1a48417b612d55fda094ddc15928fc856a2235f6ea718788929298bd1b321b92::math_utils::safe_pow(10, ((v0 - v1) as u128)) as u64))
        } else {
            arg1 / (0x1a48417b612d55fda094ddc15928fc856a2235f6ea718788929298bd1b321b92::math_utils::safe_pow(10, ((v1 - v0) as u128)) as u64)
        }
    }

    public fun convert_stablecoin_to_ausd<T0>(arg0: &Vault<T0>, arg1: u64) : u64 {
        assert!(arg1 > 0, 5);
        let v0 = arg0.token_decimals;
        let v1 = 6;
        if (v0 == v1) {
            arg1
        } else if (v0 > v1) {
            arg1 / (0x1a48417b612d55fda094ddc15928fc856a2235f6ea718788929298bd1b321b92::math_utils::safe_pow(10, ((v0 - v1) as u128)) as u64)
        } else {
            0x1a48417b612d55fda094ddc15928fc856a2235f6ea718788929298bd1b321b92::math_utils::safe_mul_u64(arg1, (0x1a48417b612d55fda094ddc15928fc856a2235f6ea718788929298bd1b321b92::math_utils::safe_pow(10, ((v1 - v0) as u128)) as u64))
        }
    }

    public fun create_vault<T0>(arg0: &VaultRegistry, arg1: &0x6c0798e31f86d7afc87c7c4582525c6c7f8fcf4244a08324388720fbd8918848::vault_governance::GovernanceRegistry, arg2: u8, arg3: &mut 0x2::tx_context::TxContext) {
        verify_registry_governance_association(arg0, arg1);
        assert!(0x6c0798e31f86d7afc87c7c4582525c6c7f8fcf4244a08324388720fbd8918848::vault_governance::is_admin(arg1, 0x2::tx_context::sender(arg3)), 1);
        let v0 = Vault<T0>{
            id                : 0x2::object::new(arg3),
            registry_id       : 0x2::object::id<VaultRegistry>(arg0),
            staked_balance    : 0x2::balance::zero<T0>(),
            total_ausd_minted : 0,
            user_stakes       : 0x2::table::new<address, u64>(arg3),
            stake_records     : 0x2::table::new<0x2::object::ID, StakeRecord>(arg3),
            user_stake_ids    : 0x2::table::new<address, vector<0x2::object::ID>>(arg3),
            next_stake_id     : 0,
            total_user_staked : 0,
            redemption_fee    : 0,
            is_paused         : false,
            token_decimals    : arg2,
        };
        0x2::transfer::share_object<Vault<T0>>(v0);
    }

    public fun deposit<T0>(arg0: &mut Vault<T0>, arg1: &VaultRegistry, arg2: &0x6c0798e31f86d7afc87c7c4582525c6c7f8fcf4244a08324388720fbd8918848::vault_governance::GovernanceRegistry, arg3: 0x2::coin::Coin<T0>, arg4: &mut 0x2::tx_context::TxContext) {
        verify_vault_registry_association<T0>(arg0, arg1);
        verify_registry_governance_association(arg1, arg2);
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(0x6c0798e31f86d7afc87c7c4582525c6c7f8fcf4244a08324388720fbd8918848::vault_governance::is_admin(arg2, v0), 1);
        let v1 = 0x2::coin::value<T0>(&arg3);
        assert!(v1 > 0, 5);
        0x2::balance::join<T0>(&mut arg0.staked_balance, 0x2::coin::into_balance<T0>(arg3));
        let v2 = DepositEvent{
            depositor  : v0,
            token_type : 0x1::string::utf8(b"TOKEN"),
            amount     : v1,
        };
        0x2::event::emit<DepositEvent>(v2);
    }

    public fun deposit_ausd(arg0: &mut VaultRegistry, arg1: &0x6c0798e31f86d7afc87c7c4582525c6c7f8fcf4244a08324388720fbd8918848::vault_governance::GovernanceRegistry, arg2: 0x2::coin::Coin<0xd5dcd0e791949074b70af25dd6b0c2e121adcfa8a062a779846bf1dd5e0f4b9a::ausd::AUSD>, arg3: &0x2::tx_context::TxContext) {
        verify_registry_governance_association(arg0, arg1);
        assert!(0x6c0798e31f86d7afc87c7c4582525c6c7f8fcf4244a08324388720fbd8918848::vault_governance::is_admin(arg1, 0x2::tx_context::sender(arg3)), 1);
        assert!(0x2::coin::value<0xd5dcd0e791949074b70af25dd6b0c2e121adcfa8a062a779846bf1dd5e0f4b9a::ausd::AUSD>(&arg2) > 0, 5);
        0x2::balance::join<0xd5dcd0e791949074b70af25dd6b0c2e121adcfa8a062a779846bf1dd5e0f4b9a::ausd::AUSD>(&mut arg0.ausd_pool, 0x2::coin::into_balance<0xd5dcd0e791949074b70af25dd6b0c2e121adcfa8a062a779846bf1dd5e0f4b9a::ausd::AUSD>(arg2));
    }

    public fun get_user_stake<T0>(arg0: &Vault<T0>, arg1: address) : u64 {
        if (0x2::table::contains<address, u64>(&arg0.user_stakes, arg1)) {
            *0x2::table::borrow<address, u64>(&arg0.user_stakes, arg1)
        } else {
            0
        }
    }

    public fun get_user_stake_records<T0>(arg0: &Vault<T0>, arg1: address) : vector<StakeRecord> {
        if (0x2::table::contains<address, vector<0x2::object::ID>>(&arg0.user_stake_ids, arg1)) {
            let v1 = 0x2::table::borrow<address, vector<0x2::object::ID>>(&arg0.user_stake_ids, arg1);
            let v2 = 0x1::vector::empty<StakeRecord>();
            let v3 = 0;
            while (v3 < 0x1::vector::length<0x2::object::ID>(v1)) {
                let v4 = *0x1::vector::borrow<0x2::object::ID>(v1, v3);
                if (0x2::table::contains<0x2::object::ID, StakeRecord>(&arg0.stake_records, v4)) {
                    0x1::vector::push_back<StakeRecord>(&mut v2, *0x2::table::borrow<0x2::object::ID, StakeRecord>(&arg0.stake_records, v4));
                };
                v3 = v3 + 1;
            };
            v2
        } else {
            0x1::vector::empty<StakeRecord>()
        }
    }

    public fun get_vault_details<T0>(arg0: &Vault<T0>) : (0x2::object::ID, u64, u64, u64, u64, bool) {
        (arg0.registry_id, 0x2::balance::value<T0>(&arg0.staked_balance), arg0.total_ausd_minted, arg0.total_user_staked, arg0.redemption_fee, arg0.is_paused)
    }

    public fun get_vault_registry_details(arg0: &VaultRegistry) : (0x2::object::ID, u64, u64, u64) {
        (arg0.governance_registry_id, 0x2::balance::value<0xd5dcd0e791949074b70af25dd6b0c2e121adcfa8a062a779846bf1dd5e0f4b9a::ausd::AUSD>(&arg0.ausd_pool), arg0.total_ausd_distributed, arg0.total_redemption_fee)
    }

    fun init(arg0: STABLECOIN_VAULT, arg1: &mut 0x2::tx_context::TxContext) {
    }

    public fun init_vault_registry(arg0: &0x6c0798e31f86d7afc87c7c4582525c6c7f8fcf4244a08324388720fbd8918848::vault_governance::GovernanceRegistry, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x6c0798e31f86d7afc87c7c4582525c6c7f8fcf4244a08324388720fbd8918848::vault_governance::is_admin(arg0, 0x2::tx_context::sender(arg1)), 1);
        let v0 = VaultRegistry{
            id                     : 0x2::object::new(arg1),
            governance_registry_id : 0x2::object::id<0x6c0798e31f86d7afc87c7c4582525c6c7f8fcf4244a08324388720fbd8918848::vault_governance::GovernanceRegistry>(arg0),
            ausd_pool              : 0x2::balance::zero<0xd5dcd0e791949074b70af25dd6b0c2e121adcfa8a062a779846bf1dd5e0f4b9a::ausd::AUSD>(),
            total_ausd_distributed : 0,
            total_redemption_fee   : 0,
        };
        0x2::transfer::share_object<VaultRegistry>(v0);
    }

    entry fun redeem<T0>(arg0: &mut Vault<T0>, arg1: &mut VaultRegistry, arg2: &0x6c0798e31f86d7afc87c7c4582525c6c7f8fcf4244a08324388720fbd8918848::vault_governance::GovernanceRegistry, arg3: 0x2::coin::Coin<0xd5dcd0e791949074b70af25dd6b0c2e121adcfa8a062a779846bf1dd5e0f4b9a::ausd::AUSD>, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        verify_vault_registry_association<T0>(arg0, arg1);
        verify_registry_governance_association(arg1, arg2);
        assert!(!0x6c0798e31f86d7afc87c7c4582525c6c7f8fcf4244a08324388720fbd8918848::vault_governance::is_governance_paused(arg2) && !arg0.is_paused, 2);
        let v0 = 0x2::coin::value<0xd5dcd0e791949074b70af25dd6b0c2e121adcfa8a062a779846bf1dd5e0f4b9a::ausd::AUSD>(&arg3);
        assert!(v0 > 0, 5);
        assert!(arg4 > 0, 5);
        let v1 = 0x2::tx_context::sender(arg7);
        let v2 = convert_ausd_to_stablecoin<T0>(arg0, arg4);
        let v3 = calculate_redemption_fee<T0>(arg0, v1, arg4, v2, arg6);
        let v4 = arg4 + v3;
        assert!(v0 >= v4, 5);
        assert!(0x2::table::contains<address, u64>(&arg0.user_stakes, v1), 3);
        let v5 = 0x2::table::borrow_mut<address, u64>(&mut arg0.user_stakes, v1);
        assert!(*v5 >= arg4, 3);
        *v5 = *v5 - arg4;
        if (*v5 == 0) {
            0x2::table::remove<address, u64>(&mut arg0.user_stakes, v1);
        };
        if (0x2::table::contains<address, vector<0x2::object::ID>>(&arg0.user_stake_ids, v1)) {
            let v6 = 0x2::table::borrow_mut<address, vector<0x2::object::ID>>(&mut arg0.user_stake_ids, v1);
            let v7 = arg4;
            let v8 = 0;
            while (v7 > 0 && v8 < 0x1::vector::length<0x2::object::ID>(v6)) {
                let v9 = *0x1::vector::borrow<0x2::object::ID>(v6, v8);
                if (0x2::table::contains<0x2::object::ID, StakeRecord>(&arg0.stake_records, v9)) {
                    let v10 = 0x2::table::borrow_mut<0x2::object::ID, StakeRecord>(&mut arg0.stake_records, v9);
                    if (v10.ausd_amount > v7) {
                        v10.ausd_amount = v10.ausd_amount - v7;
                        v7 = 0;
                        continue
                    };
                    v7 = v7 - v10.ausd_amount;
                    v10.is_active = false;
                    0x1::vector::remove<0x2::object::ID>(v6, v8);
                };
            };
            if (0x1::vector::length<0x2::object::ID>(v6) == 0) {
                0x2::table::remove<address, vector<0x2::object::ID>>(&mut arg0.user_stake_ids, v1);
            };
        };
        if (v0 == v4) {
            0x2::balance::join<0xd5dcd0e791949074b70af25dd6b0c2e121adcfa8a062a779846bf1dd5e0f4b9a::ausd::AUSD>(&mut arg1.ausd_pool, 0x2::coin::into_balance<0xd5dcd0e791949074b70af25dd6b0c2e121adcfa8a062a779846bf1dd5e0f4b9a::ausd::AUSD>(arg3));
        } else {
            0x2::balance::join<0xd5dcd0e791949074b70af25dd6b0c2e121adcfa8a062a779846bf1dd5e0f4b9a::ausd::AUSD>(&mut arg1.ausd_pool, 0x2::coin::into_balance<0xd5dcd0e791949074b70af25dd6b0c2e121adcfa8a062a779846bf1dd5e0f4b9a::ausd::AUSD>(0x2::coin::split<0xd5dcd0e791949074b70af25dd6b0c2e121adcfa8a062a779846bf1dd5e0f4b9a::ausd::AUSD>(&mut arg3, v4, arg7)));
            0x2::transfer::public_transfer<0x2::coin::Coin<0xd5dcd0e791949074b70af25dd6b0c2e121adcfa8a062a779846bf1dd5e0f4b9a::ausd::AUSD>>(arg3, v1);
        };
        assert!(v2 >= arg5, 9);
        assert!(0x2::balance::value<T0>(&arg0.staked_balance) >= v2, 8);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.staked_balance, v2), arg7), v1);
        arg0.total_user_staked = arg0.total_user_staked - v2;
        arg0.total_ausd_minted = arg0.total_ausd_minted - arg4;
        arg1.total_ausd_distributed = arg1.total_ausd_distributed - arg4;
        arg0.redemption_fee = arg0.redemption_fee + v3;
        arg1.total_redemption_fee = arg1.total_redemption_fee + v3;
        let v11 = RedeemEvent{
            user           : v1,
            token_type     : 0x1::string::utf8(b"STABLECOIN"),
            amount         : v2,
            ausd_recycling : v4,
            redemption_fee : v3,
            price_used     : 1000000,
        };
        0x2::event::emit<RedeemEvent>(v11);
    }

    public fun set_vault_pause<T0>(arg0: &mut Vault<T0>, arg1: &VaultRegistry, arg2: &0x6c0798e31f86d7afc87c7c4582525c6c7f8fcf4244a08324388720fbd8918848::vault_governance::GovernanceRegistry, arg3: bool, arg4: &0x2::tx_context::TxContext) {
        verify_vault_registry_association<T0>(arg0, arg1);
        verify_registry_governance_association(arg1, arg2);
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(0x6c0798e31f86d7afc87c7c4582525c6c7f8fcf4244a08324388720fbd8918848::vault_governance::is_admin(arg2, v0), 1);
        if (arg0.is_paused == arg3) {
            return
        };
        arg0.is_paused = arg3;
        let v1 = VaultPauseEvent{
            vault_id  : 0x2::object::uid_to_inner(&arg0.id),
            is_paused : arg3,
            admin     : v0,
        };
        0x2::event::emit<VaultPauseEvent>(v1);
    }

    entry fun stake<T0>(arg0: &mut Vault<T0>, arg1: &mut VaultRegistry, arg2: &0x6c0798e31f86d7afc87c7c4582525c6c7f8fcf4244a08324388720fbd8918848::vault_governance::GovernanceRegistry, arg3: 0x2::coin::Coin<T0>, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        verify_vault_registry_association<T0>(arg0, arg1);
        verify_registry_governance_association(arg1, arg2);
        assert!(!0x6c0798e31f86d7afc87c7c4582525c6c7f8fcf4244a08324388720fbd8918848::vault_governance::is_governance_paused(arg2) && !arg0.is_paused, 2);
        let v0 = 0x2::coin::value<T0>(&arg3);
        assert!(v0 > 0, 5);
        let v1 = convert_stablecoin_to_ausd<T0>(arg0, v0);
        assert!(v1 >= arg4, 9);
        let v2 = 0x2::tx_context::sender(arg6);
        assert!(0x2::balance::value<0xd5dcd0e791949074b70af25dd6b0c2e121adcfa8a062a779846bf1dd5e0f4b9a::ausd::AUSD>(&arg1.ausd_pool) >= v1, 3);
        0x2::balance::join<T0>(&mut arg0.staked_balance, 0x2::coin::into_balance<T0>(arg3));
        if (0x2::table::contains<address, u64>(&arg0.user_stakes, v2)) {
            let v3 = 0x2::table::borrow_mut<address, u64>(&mut arg0.user_stakes, v2);
            *v3 = *v3 + v1;
        } else {
            0x2::table::add<address, u64>(&mut arg0.user_stakes, v2, v1);
        };
        let v4 = arg0.next_stake_id;
        arg0.next_stake_id = arg0.next_stake_id + 1;
        let v5 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v5, 0x2::bcs::to_bytes<address>(&v2));
        0x1::vector::append<u8>(&mut v5, 0x2::bcs::to_bytes<u64>(&v4));
        let v6 = 0x2::object::id_from_bytes(0x2::hash::keccak256(&v5));
        let v7 = StakeRecord{
            id          : v6,
            user        : v2,
            ausd_amount : v1,
            timestamp   : 0x2::clock::timestamp_ms(arg5),
            is_active   : true,
        };
        0x2::table::add<0x2::object::ID, StakeRecord>(&mut arg0.stake_records, v6, v7);
        if (0x2::table::contains<address, vector<0x2::object::ID>>(&arg0.user_stake_ids, v2)) {
            0x1::vector::push_back<0x2::object::ID>(0x2::table::borrow_mut<address, vector<0x2::object::ID>>(&mut arg0.user_stake_ids, v2), v6);
        } else {
            let v8 = 0x1::vector::empty<0x2::object::ID>();
            0x1::vector::push_back<0x2::object::ID>(&mut v8, v6);
            0x2::table::add<address, vector<0x2::object::ID>>(&mut arg0.user_stake_ids, v2, v8);
        };
        arg0.total_user_staked = arg0.total_user_staked + v0;
        arg0.total_ausd_minted = arg0.total_ausd_minted + v1;
        arg1.total_ausd_distributed = arg1.total_ausd_distributed + v1;
        0x2::transfer::public_transfer<0x2::coin::Coin<0xd5dcd0e791949074b70af25dd6b0c2e121adcfa8a062a779846bf1dd5e0f4b9a::ausd::AUSD>>(0x2::coin::from_balance<0xd5dcd0e791949074b70af25dd6b0c2e121adcfa8a062a779846bf1dd5e0f4b9a::ausd::AUSD>(0x2::balance::split<0xd5dcd0e791949074b70af25dd6b0c2e121adcfa8a062a779846bf1dd5e0f4b9a::ausd::AUSD>(&mut arg1.ausd_pool, v1), arg6), v2);
        let v9 = StakeEvent{
            user        : v2,
            token_type  : 0x1::string::utf8(b"STABLECOIN"),
            amount      : v0,
            ausd_minted : v1,
            price_used  : 1000000,
        };
        0x2::event::emit<StakeEvent>(v9);
    }

    fun verify_registry_governance_association(arg0: &VaultRegistry, arg1: &0x6c0798e31f86d7afc87c7c4582525c6c7f8fcf4244a08324388720fbd8918848::vault_governance::GovernanceRegistry) {
        assert!(arg0.governance_registry_id == 0x2::object::id<0x6c0798e31f86d7afc87c7c4582525c6c7f8fcf4244a08324388720fbd8918848::vault_governance::GovernanceRegistry>(arg1), 7);
    }

    fun verify_vault_registry_association<T0>(arg0: &Vault<T0>, arg1: &VaultRegistry) {
        assert!(arg0.registry_id == 0x2::object::id<VaultRegistry>(arg1), 6);
    }

    public fun withdraw<T0>(arg0: &mut Vault<T0>, arg1: &VaultRegistry, arg2: &0x6c0798e31f86d7afc87c7c4582525c6c7f8fcf4244a08324388720fbd8918848::vault_governance::GovernanceRegistry, arg3: address, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        verify_vault_registry_association<T0>(arg0, arg1);
        verify_registry_governance_association(arg1, arg2);
        assert!(0x6c0798e31f86d7afc87c7c4582525c6c7f8fcf4244a08324388720fbd8918848::vault_governance::is_admin(arg2, 0x2::tx_context::sender(arg5)), 1);
        assert!(0x6c0798e31f86d7afc87c7c4582525c6c7f8fcf4244a08324388720fbd8918848::vault_governance::is_whitelisted(arg2, arg3), 4);
        assert!(arg4 > 0, 5);
        assert!(0x2::balance::value<T0>(&arg0.staked_balance) >= arg4, 3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.staked_balance, arg4), arg5), arg3);
        let v0 = WithdrawEvent{
            recipient  : arg3,
            token_type : 0x1::string::utf8(b"TOKEN"),
            amount     : arg4,
        };
        0x2::event::emit<WithdrawEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

