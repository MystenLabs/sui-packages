module 0xf016ad3e6925035b8cb7ef55a88f76af061946852637df4f5f4c942d5847e622::stake_frontier {
    struct STAKE_FRONTIER has drop {
        dummy_field: bool,
    }

    struct NftKey has copy, drop, store {
        dummy_field: bool,
    }

    struct StakedNft has store, key {
        id: 0x2::object::UID,
        nft_id: 0x2::object::ID,
        token_id: u64,
        staker: address,
        stake_timestamp_ms: u64,
    }

    struct StakeInfo has drop, store {
        nft_id: 0x2::object::ID,
        token_id: u64,
        staker: address,
        stake_timestamp_ms: u64,
    }

    struct UserStakeInfo has drop, store {
        nft_id: 0x2::object::ID,
        token_id: u64,
        stake_timestamp_ms: u64,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
        pool_id: 0x2::object::ID,
    }

    struct Staked has copy, drop {
        user: address,
        nft_id: 0x2::object::ID,
        token_id: u64,
        timestamp: u64,
    }

    struct Unstaked has copy, drop {
        user: address,
        nft_id: 0x2::object::ID,
        token_id: u64,
        timestamp: u64,
    }

    struct CapEvent has copy, drop {
        cap_type: 0x1::string::String,
        action: 0x1::string::String,
        cap_id: 0x2::object::ID,
        actor: address,
        recipient: 0x1::option::Option<address>,
    }

    struct MaxStakePerUserChanged has copy, drop {
        old_value: u64,
        new_value: u64,
        actor: address,
    }

    struct PauseStateChanged has copy, drop {
        is_paused: bool,
        actor: address,
    }

    struct MultisigConfigChanged has copy, drop {
        num_signers: u64,
        threshold: u16,
        actor: address,
    }

    struct StakingPool has key {
        id: 0x2::object::UID,
        is_paused: bool,
        max_stake_per_user: u64,
        staked_nfts: 0x2::linked_table::LinkedTable<0x2::object::ID, StakedNft>,
        staker_to_nfts: 0x2::table::Table<address, 0x2::linked_table::LinkedTable<0x2::object::ID, bool>>,
        staker_nft_counts: 0x2::table::Table<address, u64>,
        multisig_configured: bool,
        multisig_pks: vector<vector<u8>>,
        multisig_weights: vector<u8>,
        multisig_threshold: u16,
        pending_admin: 0x1::option::Option<address>,
        pending_admin_accepted: bool,
    }

    public fun accept_admin_cap(arg0: &mut StakingPool, arg1: &0x2::tx_context::TxContext) {
        assert!(0x1::option::is_some<address>(&arg0.pending_admin), 11);
        assert!(*0x1::option::borrow<address>(&arg0.pending_admin) == 0x2::tx_context::sender(arg1), 10);
        arg0.pending_admin_accepted = true;
        let v0 = CapEvent{
            cap_type  : 0x1::string::utf8(b"AdminCap"),
            action    : 0x1::string::utf8(b"transfer_accepted"),
            cap_id    : 0x2::object::id_from_address(@0x0),
            actor     : 0x2::tx_context::sender(arg1),
            recipient : 0x1::option::some<address>(0x2::tx_context::sender(arg1)),
        };
        0x2::event::emit<CapEvent>(v0);
    }

    public fun accept_admin_cap_execute(arg0: &mut StakingPool, arg1: AdminCap, arg2: &0x2::tx_context::TxContext) {
        assert!(0x1::option::is_some<address>(&arg0.pending_admin), 11);
        assert!(arg0.pending_admin_accepted == true, 13);
        let v0 = *0x1::option::borrow<address>(&arg0.pending_admin);
        arg0.pending_admin = 0x1::option::none<address>();
        arg0.pending_admin_accepted = false;
        let v1 = CapEvent{
            cap_type  : 0x1::string::utf8(b"AdminCap"),
            action    : 0x1::string::utf8(b"transfer_completed"),
            cap_id    : 0x2::object::id<AdminCap>(&arg1),
            actor     : 0x2::tx_context::sender(arg2),
            recipient : 0x1::option::some<address>(v0),
        };
        0x2::event::emit<CapEvent>(v1);
        0x2::transfer::public_transfer<AdminCap>(arg1, v0);
    }

    public fun admin_stake(arg0: &mut StakingPool, arg1: &AdminCap, arg2: vector<0x7c15e41f700298c6d3e90b50c430d58b30a70467aa39cac54034d201f4ae9fc5::xociety_frontier::XocietyFrontier>, arg3: vector<address>, arg4: vector<u64>, arg5: &mut 0x2::tx_context::TxContext) {
        verify_multisig_sender(arg0, arg5);
        assert!(0x2::object::id<StakingPool>(arg0) == arg1.pool_id, 9);
        assert!(!arg0.is_paused, 3);
        let v0 = 0x1::vector::length<0x7c15e41f700298c6d3e90b50c430d58b30a70467aa39cac54034d201f4ae9fc5::xociety_frontier::XocietyFrontier>(&arg2);
        assert!(v0 > 0, 5);
        assert!(v0 == 0x1::vector::length<address>(&arg3), 6);
        assert!(v0 == 0x1::vector::length<u64>(&arg4), 6);
        let v1 = 0x2::table::new<address, u64>(arg5);
        let v2 = 0;
        while (v2 < v0) {
            let v3 = *0x1::vector::borrow<address>(&arg3, v2);
            if (0x2::table::contains<address, u64>(&v1, v3)) {
                let v4 = 0x2::table::borrow_mut<address, u64>(&mut v1, v3);
                *v4 = *v4 + 1;
            } else {
                0x2::table::add<address, u64>(&mut v1, v3, 1);
            };
            v2 = v2 + 1;
        };
        let v5 = 0x1::vector::empty<address>();
        let v6 = 0;
        while (v6 < v0) {
            let v7 = *0x1::vector::borrow<address>(&arg3, v6);
            if (!0x1::vector::contains<address>(&v5, &v7)) {
                assert!(get_user_stake_count(arg0, v7) + *0x2::table::borrow<address, u64>(&v1, v7) <= arg0.max_stake_per_user, 4);
                0x1::vector::push_back<address>(&mut v5, v7);
            };
            v6 = v6 + 1;
        };
        0x2::table::drop<address, u64>(v1);
        while (!0x1::vector::is_empty<0x7c15e41f700298c6d3e90b50c430d58b30a70467aa39cac54034d201f4ae9fc5::xociety_frontier::XocietyFrontier>(&arg2)) {
            do_stake(arg0, 0x1::vector::pop_back<0x7c15e41f700298c6d3e90b50c430d58b30a70467aa39cac54034d201f4ae9fc5::xociety_frontier::XocietyFrontier>(&mut arg2), 0x1::vector::pop_back<address>(&mut arg3), 0x1::vector::pop_back<u64>(&mut arg4), arg5);
        };
        0x1::vector::destroy_empty<0x7c15e41f700298c6d3e90b50c430d58b30a70467aa39cac54034d201f4ae9fc5::xociety_frontier::XocietyFrontier>(arg2);
        0x1::vector::destroy_empty<address>(arg3);
        0x1::vector::destroy_empty<u64>(arg4);
    }

    fun do_stake(arg0: &mut StakingPool, arg1: 0x7c15e41f700298c6d3e90b50c430d58b30a70467aa39cac54034d201f4ae9fc5::xociety_frontier::XocietyFrontier, arg2: address, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::id<0x7c15e41f700298c6d3e90b50c430d58b30a70467aa39cac54034d201f4ae9fc5::xociety_frontier::XocietyFrontier>(&arg1);
        assert!(!0x2::linked_table::contains<0x2::object::ID, StakedNft>(&arg0.staked_nfts, v0), 0);
        let v1 = 0x7c15e41f700298c6d3e90b50c430d58b30a70467aa39cac54034d201f4ae9fc5::xociety_frontier::get_token_id(&arg1);
        ensure_user_tables(arg0, arg2, arg4);
        0x2::linked_table::push_back<0x2::object::ID, bool>(0x2::table::borrow_mut<address, 0x2::linked_table::LinkedTable<0x2::object::ID, bool>>(&mut arg0.staker_to_nfts, arg2), v0, true);
        let v2 = 0x2::table::borrow_mut<address, u64>(&mut arg0.staker_nft_counts, arg2);
        *v2 = *v2 + 1;
        let v3 = StakedNft{
            id                 : 0x2::object::new(arg4),
            nft_id             : v0,
            token_id           : v1,
            staker             : arg2,
            stake_timestamp_ms : arg3,
        };
        let v4 = NftKey{dummy_field: false};
        0x2::dynamic_object_field::add<NftKey, 0x7c15e41f700298c6d3e90b50c430d58b30a70467aa39cac54034d201f4ae9fc5::xociety_frontier::XocietyFrontier>(&mut v3.id, v4, arg1);
        0x2::linked_table::push_back<0x2::object::ID, StakedNft>(&mut arg0.staked_nfts, v0, v3);
        let v5 = Staked{
            user      : arg2,
            nft_id    : v0,
            token_id  : v1,
            timestamp : arg3,
        };
        0x2::event::emit<Staked>(v5);
    }

    fun do_unstake(arg0: &mut StakingPool, arg1: 0x2::object::ID, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        assert!(0x2::linked_table::contains<0x2::object::ID, StakedNft>(&arg0.staked_nfts, arg1), 1);
        let StakedNft {
            id                 : v0,
            nft_id             : _,
            token_id           : v2,
            staker             : v3,
            stake_timestamp_ms : _,
        } = 0x2::linked_table::remove<0x2::object::ID, StakedNft>(&mut arg0.staked_nfts, arg1);
        let v5 = v0;
        assert!(v3 == 0x2::tx_context::sender(arg3), 2);
        let v6 = NftKey{dummy_field: false};
        0x2::object::delete(v5);
        let v7 = 0x2::table::borrow_mut<address, 0x2::linked_table::LinkedTable<0x2::object::ID, bool>>(&mut arg0.staker_to_nfts, v3);
        assert!(0x2::linked_table::contains<0x2::object::ID, bool>(v7, arg1), 1);
        0x2::linked_table::remove<0x2::object::ID, bool>(v7, arg1);
        let v8 = 0x2::table::borrow_mut<address, u64>(&mut arg0.staker_nft_counts, v3);
        *v8 = *v8 - 1;
        if (*v8 == 0) {
            0x2::linked_table::destroy_empty<0x2::object::ID, bool>(0x2::table::remove<address, 0x2::linked_table::LinkedTable<0x2::object::ID, bool>>(&mut arg0.staker_to_nfts, v3));
            0x2::table::remove<address, u64>(&mut arg0.staker_nft_counts, v3);
        };
        0x2::transfer::public_transfer<0x7c15e41f700298c6d3e90b50c430d58b30a70467aa39cac54034d201f4ae9fc5::xociety_frontier::XocietyFrontier>(0x2::dynamic_object_field::remove<NftKey, 0x7c15e41f700298c6d3e90b50c430d58b30a70467aa39cac54034d201f4ae9fc5::xociety_frontier::XocietyFrontier>(&mut v5, v6), v3);
        let v9 = Unstaked{
            user      : v3,
            nft_id    : arg1,
            token_id  : v2,
            timestamp : arg2,
        };
        0x2::event::emit<Unstaked>(v9);
    }

    fun ensure_user_tables(arg0: &mut StakingPool, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        if (!0x2::table::contains<address, 0x2::linked_table::LinkedTable<0x2::object::ID, bool>>(&arg0.staker_to_nfts, arg1)) {
            0x2::table::add<address, 0x2::linked_table::LinkedTable<0x2::object::ID, bool>>(&mut arg0.staker_to_nfts, arg1, 0x2::linked_table::new<0x2::object::ID, bool>(arg2));
            0x2::table::add<address, u64>(&mut arg0.staker_nft_counts, arg1, 0);
        };
    }

    public fun get_all_stakes(arg0: &StakingPool) : vector<StakeInfo> {
        let v0 = 0x1::vector::empty<StakeInfo>();
        let v1 = 0x2::linked_table::front<0x2::object::ID, StakedNft>(&arg0.staked_nfts);
        while (0x1::option::is_some<0x2::object::ID>(v1)) {
            let v2 = *0x1::option::borrow<0x2::object::ID>(v1);
            let v3 = 0x2::linked_table::borrow<0x2::object::ID, StakedNft>(&arg0.staked_nfts, v2);
            let v4 = StakeInfo{
                nft_id             : v2,
                token_id           : v3.token_id,
                staker             : v3.staker,
                stake_timestamp_ms : v3.stake_timestamp_ms,
            };
            0x1::vector::push_back<StakeInfo>(&mut v0, v4);
            v1 = 0x2::linked_table::next<0x2::object::ID, StakedNft>(&arg0.staked_nfts, v2);
        };
        v0
    }

    public fun get_max_stake_per_user(arg0: &StakingPool) : u64 {
        arg0.max_stake_per_user
    }

    public fun get_multisig_address(arg0: &StakingPool) : address {
        assert!(arg0.multisig_configured, 8);
        0xf016ad3e6925035b8cb7ef55a88f76af061946852637df4f5f4c942d5847e622::multisig::derive_multisig_address_quiet(arg0.multisig_pks, arg0.multisig_weights, arg0.multisig_threshold)
    }

    public fun get_stake_info(arg0: &StakingPool, arg1: 0x2::object::ID) : (address, u64) {
        assert!(0x2::linked_table::contains<0x2::object::ID, StakedNft>(&arg0.staked_nfts, arg1), 1);
        let v0 = 0x2::linked_table::borrow<0x2::object::ID, StakedNft>(&arg0.staked_nfts, arg1);
        (v0.staker, v0.stake_timestamp_ms)
    }

    public fun get_staked_count_for_user(arg0: &StakingPool, arg1: address) : u64 {
        get_user_stake_count(arg0, arg1)
    }

    fun get_user_stake_count(arg0: &StakingPool, arg1: address) : u64 {
        if (0x2::table::contains<address, u64>(&arg0.staker_nft_counts, arg1)) {
            *0x2::table::borrow<address, u64>(&arg0.staker_nft_counts, arg1)
        } else {
            0
        }
    }

    public fun get_user_stakes(arg0: &StakingPool, arg1: address) : vector<UserStakeInfo> {
        let v0 = 0x1::vector::empty<UserStakeInfo>();
        if (0x2::table::contains<address, 0x2::linked_table::LinkedTable<0x2::object::ID, bool>>(&arg0.staker_to_nfts, arg1)) {
            let v1 = 0x2::table::borrow<address, 0x2::linked_table::LinkedTable<0x2::object::ID, bool>>(&arg0.staker_to_nfts, arg1);
            let v2 = 0x2::linked_table::front<0x2::object::ID, bool>(v1);
            while (0x1::option::is_some<0x2::object::ID>(v2)) {
                let v3 = *0x1::option::borrow<0x2::object::ID>(v2);
                let v4 = 0x2::linked_table::borrow<0x2::object::ID, StakedNft>(&arg0.staked_nfts, v3);
                let v5 = UserStakeInfo{
                    nft_id             : v3,
                    token_id           : v4.token_id,
                    stake_timestamp_ms : v4.stake_timestamp_ms,
                };
                0x1::vector::push_back<UserStakeInfo>(&mut v0, v5);
                v2 = 0x2::linked_table::next<0x2::object::ID, bool>(v1, v3);
            };
        };
        v0
    }

    fun init(arg0: STAKE_FRONTIER, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = StakingPool{
            id                     : 0x2::object::new(arg1),
            is_paused              : false,
            max_stake_per_user     : 25,
            staked_nfts            : 0x2::linked_table::new<0x2::object::ID, StakedNft>(arg1),
            staker_to_nfts         : 0x2::table::new<address, 0x2::linked_table::LinkedTable<0x2::object::ID, bool>>(arg1),
            staker_nft_counts      : 0x2::table::new<address, u64>(arg1),
            multisig_configured    : false,
            multisig_pks           : 0x1::vector::empty<vector<u8>>(),
            multisig_weights       : 0x1::vector::empty<u8>(),
            multisig_threshold     : 0,
            pending_admin          : 0x1::option::none<address>(),
            pending_admin_accepted : false,
        };
        let v1 = AdminCap{
            id      : 0x2::object::new(arg1),
            pool_id : 0x2::object::id<StakingPool>(&v0),
        };
        let v2 = CapEvent{
            cap_type  : 0x1::string::utf8(b"AdminCap"),
            action    : 0x1::string::utf8(b"created"),
            cap_id    : 0x2::object::id<AdminCap>(&v1),
            actor     : 0x2::tx_context::sender(arg1),
            recipient : 0x1::option::some<address>(0x2::tx_context::sender(arg1)),
        };
        0x2::event::emit<CapEvent>(v2);
        0x2::transfer::public_transfer<AdminCap>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::share_object<StakingPool>(v0);
    }

    public fun is_multisig_configured(arg0: &StakingPool) : bool {
        arg0.multisig_configured
    }

    public fun is_paused(arg0: &StakingPool) : bool {
        arg0.is_paused
    }

    public fun pause(arg0: &mut StakingPool, arg1: &AdminCap, arg2: &0x2::tx_context::TxContext) {
        verify_multisig_sender(arg0, arg2);
        assert!(0x2::object::id<StakingPool>(arg0) == arg1.pool_id, 9);
        arg0.is_paused = true;
        let v0 = PauseStateChanged{
            is_paused : true,
            actor     : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<PauseStateChanged>(v0);
    }

    public fun renounce_admin_cap_transfer(arg0: &mut StakingPool, arg1: &AdminCap, arg2: &0x2::tx_context::TxContext) {
        assert!(0x1::option::is_some<address>(&arg0.pending_admin), 11);
        arg0.pending_admin = 0x1::option::none<address>();
        arg0.pending_admin_accepted = false;
        let v0 = CapEvent{
            cap_type  : 0x1::string::utf8(b"AdminCap"),
            action    : 0x1::string::utf8(b"transfer_renounced"),
            cap_id    : 0x2::object::id<AdminCap>(arg1),
            actor     : 0x2::tx_context::sender(arg2),
            recipient : 0x1::option::some<address>(*0x1::option::borrow<address>(&arg0.pending_admin)),
        };
        0x2::event::emit<CapEvent>(v0);
    }

    public fun set_max_stake_per_user(arg0: &mut StakingPool, arg1: &AdminCap, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        verify_multisig_sender(arg0, arg3);
        assert!(0x2::object::id<StakingPool>(arg0) == arg1.pool_id, 9);
        arg0.max_stake_per_user = arg2;
        let v0 = MaxStakePerUserChanged{
            old_value : arg0.max_stake_per_user,
            new_value : arg2,
            actor     : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<MaxStakePerUserChanged>(v0);
    }

    public fun set_multisig_config(arg0: &mut StakingPool, arg1: &AdminCap, arg2: vector<vector<u8>>, arg3: vector<u8>, arg4: u16, arg5: &0x2::tx_context::TxContext) {
        if (arg0.multisig_configured) {
            verify_multisig_sender(arg0, arg5);
        };
        let v0 = 0x1::vector::length<vector<u8>>(&arg2);
        let v1 = 0x1::vector::length<u8>(&arg3);
        assert!(v0 > 0, 14);
        assert!(v1 > 0, 14);
        assert!(v0 <= 10, 17);
        assert!(v0 == v1, 15);
        let v2 = 0;
        while (v2 < v0) {
            let v3 = 0x1::vector::length<u8>(0x1::vector::borrow<vector<u8>>(&arg2, v2));
            let v4 = if (v3 == 32) {
                true
            } else if (v3 == 33) {
                true
            } else {
                v3 == 33
            };
            assert!(v4, 18);
            v2 = v2 + 1;
        };
        let v5 = 0;
        let v6 = 0;
        while (v6 < v1) {
            v5 = v5 + (*0x1::vector::borrow<u8>(&arg3, v6) as u16);
            v6 = v6 + 1;
        };
        assert!(arg4 > 0, 16);
        assert!(arg4 <= v5, 16);
        arg0.multisig_pks = arg2;
        arg0.multisig_weights = arg3;
        arg0.multisig_threshold = arg4;
        arg0.multisig_configured = true;
        let v7 = MultisigConfigChanged{
            num_signers : v0,
            threshold   : arg4,
            actor       : 0x2::tx_context::sender(arg5),
        };
        0x2::event::emit<MultisigConfigChanged>(v7);
    }

    public fun stake(arg0: &mut StakingPool, arg1: vector<0x7c15e41f700298c6d3e90b50c430d58b30a70467aa39cac54034d201f4ae9fc5::xociety_frontier::XocietyFrontier>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.is_paused, 3);
        assert!(0x1::vector::length<0x7c15e41f700298c6d3e90b50c430d58b30a70467aa39cac54034d201f4ae9fc5::xociety_frontier::XocietyFrontier>(&arg1) > 0, 5);
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(get_user_stake_count(arg0, v0) + 0x1::vector::length<0x7c15e41f700298c6d3e90b50c430d58b30a70467aa39cac54034d201f4ae9fc5::xociety_frontier::XocietyFrontier>(&arg1) <= arg0.max_stake_per_user, 4);
        while (0x1::vector::length<0x7c15e41f700298c6d3e90b50c430d58b30a70467aa39cac54034d201f4ae9fc5::xociety_frontier::XocietyFrontier>(&arg1) > 0) {
            do_stake(arg0, 0x1::vector::pop_back<0x7c15e41f700298c6d3e90b50c430d58b30a70467aa39cac54034d201f4ae9fc5::xociety_frontier::XocietyFrontier>(&mut arg1), v0, 0x2::clock::timestamp_ms(arg2), arg3);
        };
        0x1::vector::destroy_empty<0x7c15e41f700298c6d3e90b50c430d58b30a70467aa39cac54034d201f4ae9fc5::xociety_frontier::XocietyFrontier>(arg1);
    }

    public fun transfer_admin_cap_begin(arg0: &mut StakingPool, arg1: &AdminCap, arg2: address, arg3: &0x2::tx_context::TxContext) {
        assert!(arg2 != @0x0, 12);
        assert!(arg2 != 0x2::tx_context::sender(arg3), 12);
        arg0.pending_admin = 0x1::option::some<address>(arg2);
        arg0.pending_admin_accepted = false;
        let v0 = CapEvent{
            cap_type  : 0x1::string::utf8(b"AdminCap"),
            action    : 0x1::string::utf8(b"transfer_initiated"),
            cap_id    : 0x2::object::id<AdminCap>(arg1),
            actor     : 0x2::tx_context::sender(arg3),
            recipient : 0x1::option::some<address>(arg2),
        };
        0x2::event::emit<CapEvent>(v0);
    }

    public fun unpause(arg0: &mut StakingPool, arg1: &AdminCap, arg2: &0x2::tx_context::TxContext) {
        verify_multisig_sender(arg0, arg2);
        assert!(0x2::object::id<StakingPool>(arg0) == arg1.pool_id, 9);
        arg0.is_paused = false;
        let v0 = PauseStateChanged{
            is_paused : false,
            actor     : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<PauseStateChanged>(v0);
    }

    public fun unstake(arg0: &mut StakingPool, arg1: vector<0x2::object::ID>, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert!(!arg0.is_paused, 3);
        assert!(!0x1::vector::is_empty<0x2::object::ID>(&arg1), 5);
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x2::object::ID>(&arg1)) {
            do_unstake(arg0, *0x1::vector::borrow<0x2::object::ID>(&arg1, v0), 0x2::clock::timestamp_ms(arg2), arg3);
            v0 = v0 + 1;
        };
    }

    fun verify_multisig_sender(arg0: &StakingPool, arg1: &0x2::tx_context::TxContext) {
        assert!(arg0.multisig_configured, 8);
        assert!(0x2::tx_context::sender(arg1) == 0xf016ad3e6925035b8cb7ef55a88f76af061946852637df4f5f4c942d5847e622::multisig::derive_multisig_address_quiet(arg0.multisig_pks, arg0.multisig_weights, arg0.multisig_threshold), 7);
    }

    // decompiled from Move bytecode v6
}

