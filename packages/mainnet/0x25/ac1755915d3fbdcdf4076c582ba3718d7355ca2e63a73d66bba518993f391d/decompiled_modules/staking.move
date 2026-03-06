module 0x25ac1755915d3fbdcdf4076c582ba3718d7355ca2e63a73d66bba518993f391d::staking {
    struct StakedEvent has copy, drop {
        staker: address,
        tier: u8,
        amount: u64,
        unlock_time_sec: u64,
        rabat_bps: u16,
    }

    struct UnstakedEvent has copy, drop {
        staker: address,
        tier: u8,
        amount: u64,
    }

    struct ClaimedEvent has copy, drop {
        staker: address,
        tier: u8,
        reward: u64,
        paid_to_staker: u64,
    }

    struct AffiliatePaidEvent has copy, drop {
        staker: address,
        tier: u8,
        upline: address,
        bps: u16,
        amount: u64,
    }

    struct PermitV1 has drop, store {
        domain: vector<u8>,
        network: vector<u8>,
        staker_sui: address,
        tier: u8,
        amount: u64,
        rabat_bps: u16,
        uplines: vector<address>,
        nonce: u64,
        expires_at_ms: u64,
    }

    struct Position has store {
        tier: u8,
        staked: u64,
        accrued_reward: u64,
        last_update_sec: u64,
        unlock_time_sec: u64,
        rabat_bps: u16,
        uplines: vector<address>,
    }

    struct UserState has store {
        last_nonce: u64,
        positions: vector<Position>,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Staking has store, key {
        id: 0x2::object::UID,
        verifier_pubkey: vector<u8>,
        domain: vector<u8>,
        network: vector<u8>,
        base_bps_t0: u16,
        base_bps_t1: u16,
        base_bps_t2: u16,
        max_total_bps_per_day: u16,
        lock_t1_sec: u64,
        lock_t2_sec: u64,
        upline_bps: vector<u16>,
        max_affiliate_bps_sum: u16,
        stake_vault: 0x2::balance::Balance<0xb9e474078268920490b9da435bb6d68ae1a0d96f81664d188fa3a821f3ed4f43::idbitsui::IDBITSUI>,
        reward_vault: 0x2::balance::Balance<0xb9e474078268920490b9da435bb6d68ae1a0d96f81664d188fa3a821f3ed4f43::idbitsui::IDBITSUI>,
        users: 0x2::table::Table<address, UserState>,
    }

    fun accrue_position_cfg(arg0: &mut Position, arg1: u64, arg2: u16, arg3: u16, arg4: u16, arg5: u16) {
        if (arg1 <= arg0.last_update_sec) {
            return
        };
        arg0.last_update_sec = arg1;
        if (arg0.staked == 0) {
            return
        };
        let v0 = if (arg0.tier == 0) {
            arg2
        } else if (arg0.tier == 1) {
            arg3
        } else {
            arg4
        };
        let v1 = (v0 as u64) + (arg0.rabat_bps as u64);
        let v2 = v1;
        let v3 = (arg5 as u64);
        if (v1 > v3) {
            v2 = v3;
        };
        arg0.accrued_reward = arg0.accrued_reward + (((arg0.staked as u128) * (v2 as u128) * ((arg1 - arg0.last_update_sec) as u128) / (86400 as u128) * (10000 as u128)) as u64);
    }

    fun assert_config(arg0: &vector<u16>, arg1: u16) {
        assert!(0x1::vector::length<u16>(arg0) == 7, 13);
        assert!((arg1 as u64) <= 10000, 16);
        let v0 = (sum_bps(arg0) as u64);
        assert!(v0 <= (arg1 as u64), 14);
        assert!(v0 <= 10000, 14);
    }

    fun borrow_or_create_user(arg0: &mut Staking, arg1: address, arg2: u64) : &mut UserState {
        if (!0x2::table::contains<address, UserState>(&arg0.users, arg1)) {
            let v0 = 0x1::vector::empty<Position>();
            let v1 = Position{
                tier            : 0,
                staked          : 0,
                accrued_reward  : 0,
                last_update_sec : arg2,
                unlock_time_sec : 0,
                rabat_bps       : 0,
                uplines         : 0x1::vector::empty<address>(),
            };
            0x1::vector::push_back<Position>(&mut v0, v1);
            let v2 = Position{
                tier            : 1,
                staked          : 0,
                accrued_reward  : 0,
                last_update_sec : arg2,
                unlock_time_sec : 0,
                rabat_bps       : 0,
                uplines         : 0x1::vector::empty<address>(),
            };
            0x1::vector::push_back<Position>(&mut v0, v2);
            let v3 = Position{
                tier            : 2,
                staked          : 0,
                accrued_reward  : 0,
                last_update_sec : arg2,
                unlock_time_sec : 0,
                rabat_bps       : 0,
                uplines         : 0x1::vector::empty<address>(),
            };
            0x1::vector::push_back<Position>(&mut v0, v3);
            let v4 = UserState{
                last_nonce : 0,
                positions  : v0,
            };
            0x2::table::add<address, UserState>(&mut arg0.users, arg1, v4);
        };
        0x2::table::borrow_mut<address, UserState>(&mut arg0.users, arg1)
    }

    fun bytes_eq(arg0: &vector<u8>, arg1: &vector<u8>) : bool {
        let v0 = 0x1::vector::length<u8>(arg0);
        if (v0 != 0x1::vector::length<u8>(arg1)) {
            return false
        };
        let v1 = 0;
        while (v1 < v0) {
            if (*0x1::vector::borrow<u8>(arg0, v1) != *0x1::vector::borrow<u8>(arg1, v1)) {
                return false
            };
            v1 = v1 + 1;
        };
        true
    }

    public fun claim(arg0: &mut Staking, arg1: &0x2::clock::Clock, arg2: u8, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xb9e474078268920490b9da435bb6d68ae1a0d96f81664d188fa3a821f3ed4f43::idbitsui::IDBITSUI> {
        assert!(arg2 <= 2, 1);
        assert_config(&arg0.upline_bps, arg0.max_affiliate_bps_sum);
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(0x2::table::contains<address, UserState>(&arg0.users, v0), 15);
        let v1 = 0x1::vector::borrow_mut<Position>(&mut 0x2::table::borrow_mut<address, UserState>(&mut arg0.users, v0).positions, (arg2 as u64));
        accrue_position_cfg(v1, 0x2::clock::timestamp_ms(arg1) / 1000, arg0.base_bps_t0, arg0.base_bps_t1, arg0.base_bps_t2, arg0.max_total_bps_per_day);
        let v2 = v1.accrued_reward;
        let (v3, v4) = if (v2 > 0) {
            v1.accrued_reward = 0;
            (v2, copy_addresses(&v1.uplines))
        } else {
            (0, 0x1::vector::empty<address>())
        };
        if (v3 == 0) {
            0x2::coin::zero<0xb9e474078268920490b9da435bb6d68ae1a0d96f81664d188fa3a821f3ed4f43::idbitsui::IDBITSUI>(arg3)
        } else {
            assert!(0x2::balance::value<0xb9e474078268920490b9da435bb6d68ae1a0d96f81664d188fa3a821f3ed4f43::idbitsui::IDBITSUI>(&arg0.reward_vault) >= v3, 8);
            let (v6, v7) = pay_affiliates_and_take_staker_coin(arg0, arg2, v0, v3, v4, arg3);
            let v8 = ClaimedEvent{
                staker         : v0,
                tier           : arg2,
                reward         : v3,
                paid_to_staker : v3 - v6,
            };
            0x2::event::emit<ClaimedEvent>(v8);
            v7
        }
    }

    fun copy_addresses(arg0: &vector<address>) : vector<address> {
        let v0 = 0x1::vector::empty<address>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<address>(arg0)) {
            0x1::vector::push_back<address>(&mut v0, *0x1::vector::borrow<address>(arg0, v1));
            v1 = v1 + 1;
        };
        v0
    }

    public fun create(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) : AdminCap {
        assert!(0x1::vector::length<u8>(&arg0) == 32, 9);
        let v0 = 0x1::vector::empty<u16>();
        0x1::vector::push_back<u16>(&mut v0, 500);
        0x1::vector::push_back<u16>(&mut v0, 250);
        0x1::vector::push_back<u16>(&mut v0, 200);
        0x1::vector::push_back<u16>(&mut v0, 100);
        0x1::vector::push_back<u16>(&mut v0, 80);
        0x1::vector::push_back<u16>(&mut v0, 50);
        0x1::vector::push_back<u16>(&mut v0, 50);
        assert_config(&v0, 3000);
        let v1 = Staking{
            id                    : 0x2::object::new(arg3),
            verifier_pubkey       : arg0,
            domain                : arg1,
            network               : arg2,
            base_bps_t0           : 25,
            base_bps_t1           : 50,
            base_bps_t2           : 100,
            max_total_bps_per_day : 500,
            lock_t1_sec           : 180 * 86400,
            lock_t2_sec           : 360 * 86400,
            upline_bps            : v0,
            max_affiliate_bps_sum : 3000,
            stake_vault           : 0x2::balance::zero<0xb9e474078268920490b9da435bb6d68ae1a0d96f81664d188fa3a821f3ed4f43::idbitsui::IDBITSUI>(),
            reward_vault          : 0x2::balance::zero<0xb9e474078268920490b9da435bb6d68ae1a0d96f81664d188fa3a821f3ed4f43::idbitsui::IDBITSUI>(),
            users                 : 0x2::table::new<address, UserState>(arg3),
        };
        0x2::transfer::share_object<Staking>(v1);
        AdminCap{id: 0x2::object::new(arg3)}
    }

    fun decode_permit_v1(arg0: vector<u8>) : PermitV1 {
        let v0 = 0x2::bcs::new(arg0);
        PermitV1{
            domain        : 0x2::bcs::peel_vec_u8(&mut v0),
            network       : 0x2::bcs::peel_vec_u8(&mut v0),
            staker_sui    : 0x2::bcs::peel_address(&mut v0),
            tier          : 0x2::bcs::peel_u8(&mut v0),
            amount        : 0x2::bcs::peel_u64(&mut v0),
            rabat_bps     : 0x2::bcs::peel_u16(&mut v0),
            uplines       : 0x2::bcs::peel_vec_address(&mut v0),
            nonce         : 0x2::bcs::peel_u64(&mut v0),
            expires_at_ms : 0x2::bcs::peel_u64(&mut v0),
        }
    }

    public fun deposit_rewards(arg0: &AdminCap, arg1: &mut Staking, arg2: 0x2::coin::Coin<0xb9e474078268920490b9da435bb6d68ae1a0d96f81664d188fa3a821f3ed4f43::idbitsui::IDBITSUI>, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<0xb9e474078268920490b9da435bb6d68ae1a0d96f81664d188fa3a821f3ed4f43::idbitsui::IDBITSUI>(&mut arg1.reward_vault, 0x2::coin::into_balance<0xb9e474078268920490b9da435bb6d68ae1a0d96f81664d188fa3a821f3ed4f43::idbitsui::IDBITSUI>(arg2));
    }

    public fun get_position(arg0: &Staking, arg1: address, arg2: u8) : (u64, u64, u64, u16) {
        assert!(arg2 <= 2, 1);
        if (!0x2::table::contains<address, UserState>(&arg0.users, arg1)) {
            (0, 0, 0, 0)
        } else {
            let v4 = 0x1::vector::borrow<Position>(&0x2::table::borrow<address, UserState>(&arg0.users, arg1).positions, (arg2 as u64));
            (v4.staked, v4.accrued_reward, v4.unlock_time_sec, v4.rabat_bps)
        }
    }

    public fun has_user(arg0: &Staking, arg1: address) : bool {
        0x2::table::contains<address, UserState>(&arg0.users, arg1)
    }

    fun max_u64(arg0: u64, arg1: u64) : u64 {
        if (arg0 >= arg1) {
            arg0
        } else {
            arg1
        }
    }

    fun pay_affiliates_and_take_staker_coin(arg0: &mut Staking, arg1: u8, arg2: address, arg3: u64, arg4: vector<address>, arg5: &mut 0x2::tx_context::TxContext) : (u64, 0x2::coin::Coin<0xb9e474078268920490b9da435bb6d68ae1a0d96f81664d188fa3a821f3ed4f43::idbitsui::IDBITSUI>) {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 7) {
            let v2 = *0x1::vector::borrow<address>(&arg4, v1);
            let v3 = *0x1::vector::borrow<u16>(&arg0.upline_bps, v1);
            if (v2 != @0x0 && v3 > 0) {
                let v4 = (((arg3 as u128) * (v3 as u128) / (10000 as u128)) as u64);
                if (v4 > 0) {
                    0x2::transfer::public_transfer<0x2::coin::Coin<0xb9e474078268920490b9da435bb6d68ae1a0d96f81664d188fa3a821f3ed4f43::idbitsui::IDBITSUI>>(0x2::coin::take<0xb9e474078268920490b9da435bb6d68ae1a0d96f81664d188fa3a821f3ed4f43::idbitsui::IDBITSUI>(&mut arg0.reward_vault, v4, arg5), v2);
                    v0 = v0 + v4;
                    let v5 = AffiliatePaidEvent{
                        staker : arg2,
                        tier   : arg1,
                        upline : v2,
                        bps    : v3,
                        amount : v4,
                    };
                    0x2::event::emit<AffiliatePaidEvent>(v5);
                };
            };
            v1 = v1 + 1;
        };
        let v6 = arg3 - v0;
        let v7 = if (v6 > 0) {
            0x2::coin::take<0xb9e474078268920490b9da435bb6d68ae1a0d96f81664d188fa3a821f3ed4f43::idbitsui::IDBITSUI>(&mut arg0.reward_vault, v6, arg5)
        } else {
            0x2::coin::zero<0xb9e474078268920490b9da435bb6d68ae1a0d96f81664d188fa3a821f3ed4f43::idbitsui::IDBITSUI>(arg5)
        };
        (v0, v7)
    }

    public fun set_config(arg0: &AdminCap, arg1: &mut Staking, arg2: u16, arg3: u16, arg4: u16, arg5: u16, arg6: u64, arg7: u64, arg8: u16, arg9: vector<u16>, arg10: &mut 0x2::tx_context::TxContext) {
        assert_config(&arg9, arg8);
        arg1.base_bps_t0 = arg2;
        arg1.base_bps_t1 = arg3;
        arg1.base_bps_t2 = arg4;
        arg1.max_total_bps_per_day = arg5;
        arg1.lock_t1_sec = arg6;
        arg1.lock_t2_sec = arg7;
        arg1.max_affiliate_bps_sum = arg8;
        arg1.upline_bps = arg9;
    }

    public fun set_verifier_pubkey(arg0: &AdminCap, arg1: &mut Staking, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<u8>(&arg2) == 32, 9);
        arg1.verifier_pubkey = arg2;
    }

    public fun stake_with_permit(arg0: &mut Staking, arg1: &0x2::clock::Clock, arg2: u8, arg3: 0x2::coin::Coin<0xb9e474078268920490b9da435bb6d68ae1a0d96f81664d188fa3a821f3ed4f43::idbitsui::IDBITSUI>, arg4: vector<u8>, arg5: vector<u8>, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 <= 2, 1);
        assert!(0x1::vector::length<u8>(&arg5) == 64, 10);
        let v0 = arg0.base_bps_t0;
        let v1 = arg0.base_bps_t1;
        let v2 = arg0.base_bps_t2;
        let v3 = arg0.max_total_bps_per_day;
        let v4 = arg0.lock_t1_sec;
        let v5 = arg0.lock_t2_sec;
        assert_config(&arg0.upline_bps, arg0.max_affiliate_bps_sum);
        let v6 = 0x2::tx_context::sender(arg6);
        let v7 = 0x2::clock::timestamp_ms(arg1);
        let v8 = v7 / 1000;
        assert!(0x2::ed25519::ed25519_verify(&arg5, &arg0.verifier_pubkey, &arg4), 5);
        let v9 = decode_permit_v1(arg4);
        assert!(v9.staker_sui == v6, 2);
        assert!(v9.tier == arg2, 2);
        assert!(bytes_eq(&v9.domain, &arg0.domain), 11);
        assert!(bytes_eq(&v9.network, &arg0.network), 12);
        assert!(v7 <= v9.expires_at_ms, 3);
        let v10 = 0x2::coin::value<0xb9e474078268920490b9da435bb6d68ae1a0d96f81664d188fa3a821f3ed4f43::idbitsui::IDBITSUI>(&arg3);
        assert!(v10 == v9.amount, 6);
        assert!(0x1::vector::length<address>(&v9.uplines) == 7, 13);
        let v11 = borrow_or_create_user(arg0, v6, v8);
        assert!(v9.nonce > v11.last_nonce, 4);
        v11.last_nonce = v9.nonce;
        let v12 = 0x1::vector::borrow_mut<Position>(&mut v11.positions, (arg2 as u64));
        accrue_position_cfg(v12, v8, v0, v1, v2, v3);
        let v13 = if (arg2 == 0) {
            0
        } else if (arg2 == 1) {
            max_u64(v12.unlock_time_sec, v8 + v4)
        } else {
            max_u64(v12.unlock_time_sec, v8 + v5)
        };
        v12.unlock_time_sec = v13;
        v12.rabat_bps = v9.rabat_bps;
        v12.uplines = v9.uplines;
        v12.staked = v12.staked + v10;
        0x2::balance::join<0xb9e474078268920490b9da435bb6d68ae1a0d96f81664d188fa3a821f3ed4f43::idbitsui::IDBITSUI>(&mut arg0.stake_vault, 0x2::coin::into_balance<0xb9e474078268920490b9da435bb6d68ae1a0d96f81664d188fa3a821f3ed4f43::idbitsui::IDBITSUI>(arg3));
        let v14 = StakedEvent{
            staker          : v6,
            tier            : arg2,
            amount          : v10,
            unlock_time_sec : v13,
            rabat_bps       : v9.rabat_bps,
        };
        0x2::event::emit<StakedEvent>(v14);
    }

    fun sum_bps(arg0: &vector<u16>) : u16 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<u16>(arg0)) {
            v0 = v0 + (*0x1::vector::borrow<u16>(arg0, v1) as u64);
            v1 = v1 + 1;
        };
        (v0 as u16)
    }

    public fun unstake(arg0: &mut Staking, arg1: &0x2::clock::Clock, arg2: u8, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xb9e474078268920490b9da435bb6d68ae1a0d96f81664d188fa3a821f3ed4f43::idbitsui::IDBITSUI> {
        assert!(arg2 <= 2, 1);
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = 0x2::clock::timestamp_ms(arg1) / 1000;
        assert!(0x2::table::contains<address, UserState>(&arg0.users, v0), 15);
        let v2 = 0x1::vector::borrow_mut<Position>(&mut 0x2::table::borrow_mut<address, UserState>(&mut arg0.users, v0).positions, (arg2 as u64));
        if (arg2 != 0) {
            assert!(v1 >= v2.unlock_time_sec, 7);
        };
        accrue_position_cfg(v2, v1, arg0.base_bps_t0, arg0.base_bps_t1, arg0.base_bps_t2, arg0.max_total_bps_per_day);
        assert!(arg3 <= v2.staked, 2);
        v2.staked = v2.staked - arg3;
        let v3 = UnstakedEvent{
            staker : v0,
            tier   : arg2,
            amount : arg3,
        };
        0x2::event::emit<UnstakedEvent>(v3);
        0x2::coin::take<0xb9e474078268920490b9da435bb6d68ae1a0d96f81664d188fa3a821f3ed4f43::idbitsui::IDBITSUI>(&mut arg0.stake_vault, arg3, arg4)
    }

    // decompiled from Move bytecode v6
}

