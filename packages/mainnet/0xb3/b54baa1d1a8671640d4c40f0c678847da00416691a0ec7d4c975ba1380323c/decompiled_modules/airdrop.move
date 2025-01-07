module 0xb3b54baa1d1a8671640d4c40f0c678847da00416691a0ec7d4c975ba1380323c::airdrop {
    struct AirdropAdminCapability has key {
        id: 0x2::object::UID,
    }

    struct AirdropVault has key {
        id: 0x2::object::UID,
        merkle_tree_roots: vector<vector<u8>>,
        hive_available: 0x2::balance::Balance<0xac914b6678503487e43280ec674f997bd9894b81c0dd428c4783bdda38b938d7::hive::HIVE>,
        users_claimed_table: 0x2::table::Table<address, u64>,
        total_airdrop_amt: u64,
        total_delegated_amt: u64,
        total_withdrawn_amt: u64,
        claim_start_timestamp: u64,
        claim_end_timestamp: u64,
        withdrawals_allowed: bool,
    }

    struct HiveAirdropHolder has store, key {
        id: 0x2::object::UID,
        hive_claimed: 0x2::balance::Balance<0xac914b6678503487e43280ec674f997bd9894b81c0dd428c4783bdda38b938d7::hive::HIVE>,
    }

    struct AirdropClaimed has copy, drop {
        recipient: address,
        amount: u64,
    }

    struct AirdropUnlocked has copy, drop {
        recipient: address,
        profile_addr: address,
        username: 0x1::string::String,
        amount: u64,
    }

    public entry fun add_hive_for_airdrop(arg0: &0x2::clock::Clock, arg1: &mut AirdropVault, arg2: 0x2::coin::Coin<0xac914b6678503487e43280ec674f997bd9894b81c0dd428c4783bdda38b938d7::hive::HIVE>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::clock::timestamp_ms(arg0) < arg1.claim_end_timestamp, 4201);
        let v0 = 0x2::coin::into_balance<0xac914b6678503487e43280ec674f997bd9894b81c0dd428c4783bdda38b938d7::hive::HIVE>(arg2);
        0x2::balance::join<0xac914b6678503487e43280ec674f997bd9894b81c0dd428c4783bdda38b938d7::hive::HIVE>(&mut arg1.hive_available, 0x2::balance::split<0xac914b6678503487e43280ec674f997bd9894b81c0dd428c4783bdda38b938d7::hive::HIVE>(&mut v0, arg3));
        arg1.total_airdrop_amt = arg1.total_airdrop_amt + arg3;
        let v1 = 0x2::tx_context::sender(arg4);
        destroy_or_transfer_balance<0xac914b6678503487e43280ec674f997bd9894b81c0dd428c4783bdda38b938d7::hive::HIVE>(v0, v1, arg4);
    }

    public entry fun claim_hive_airdrop(arg0: &0x2::clock::Clock, arg1: &mut AirdropVault, arg2: u64, arg3: vector<vector<u8>>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = 0x2::clock::timestamp_ms(arg0);
        assert!(v1 < arg1.claim_end_timestamp && v1 >= arg1.claim_start_timestamp, 4202);
        assert!(0xb3b54baa1d1a8671640d4c40f0c678847da00416691a0ec7d4c975ba1380323c::merkle_proof::verify(&arg3, *0x1::vector::borrow<vector<u8>>(&arg1.merkle_tree_roots, arg4), create_leaf(v0, arg2)), 4203);
        assert!(!0x2::table::contains<address, u64>(&arg1.users_claimed_table, v0), 4204);
        0x2::table::add<address, u64>(&mut arg1.users_claimed_table, v0, arg2);
        let v2 = HiveAirdropHolder{
            id           : 0x2::object::new(arg5),
            hive_claimed : 0x2::balance::split<0xac914b6678503487e43280ec674f997bd9894b81c0dd428c4783bdda38b938d7::hive::HIVE>(&mut arg1.hive_available, arg2),
        };
        0x2::transfer::public_transfer<HiveAirdropHolder>(v2, v0);
        let v3 = AirdropClaimed{
            recipient : v0,
            amount    : arg2,
        };
        0x2::event::emit<AirdropClaimed>(v3);
    }

    fun create_leaf(arg0: address, arg1: u64) : vector<u8> {
        let v0 = 0x2::address::to_bytes(arg0);
        let v1 = 0x2::bcs::new(0x2::bcs::to_bytes<u64>(&arg1));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::peel_vec_u8(&mut v1));
        0x1::hash::sha2_256(v0)
    }

    public fun delegate_hive_for_auction(arg0: &0xf99260f5a6d66df46ca77fba5b7bc986821243eb6c429b477cae0eae10b4218a::config::AuctionCapability, arg1: &mut AirdropVault, arg2: &mut HiveAirdropHolder, arg3: u64) : 0x2::balance::Balance<0xac914b6678503487e43280ec674f997bd9894b81c0dd428c4783bdda38b938d7::hive::HIVE> {
        arg1.total_delegated_amt = arg1.total_delegated_amt + arg3;
        0x2::balance::split<0xac914b6678503487e43280ec674f997bd9894b81c0dd428c4783bdda38b938d7::hive::HIVE>(&mut arg2.hive_claimed, arg3)
    }

    fun destroy_or_transfer_balance<T0>(arg0: 0x2::balance::Balance<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        if (0x2::balance::value<T0>(&arg0) == 0) {
            0x2::balance::destroy_zero<T0>(arg0);
            return
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(arg0, arg2), arg1);
    }

    public fun enable_hive_withdrawals(arg0: &0xf99260f5a6d66df46ca77fba5b7bc986821243eb6c429b477cae0eae10b4218a::config::AuctionCapability, arg1: &mut AirdropVault) {
        arg1.withdrawals_allowed = true;
    }

    public fun get_airdrop_vault(arg0: &AirdropVault) : (u64, u64, u64, u64, u64, u64, bool) {
        (0x2::balance::value<0xac914b6678503487e43280ec674f997bd9894b81c0dd428c4783bdda38b938d7::hive::HIVE>(&arg0.hive_available), arg0.total_airdrop_amt, arg0.total_delegated_amt, arg0.total_withdrawn_amt, arg0.claim_start_timestamp, arg0.claim_end_timestamp, arg0.withdrawals_allowed)
    }

    public fun has_user_claimed(arg0: &AirdropVault, arg1: address) : (bool, u64) {
        if (0x2::table::contains<address, u64>(&arg0.users_claimed_table, arg1)) {
            (true, *0x2::table::borrow<address, u64>(&arg0.users_claimed_table, arg1))
        } else {
            (false, 0)
        }
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AirdropAdminCapability{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AirdropAdminCapability>(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun initialize_airdrop_vault(arg0: &0x2::clock::Clock, arg1: &AirdropAdminCapability, arg2: vector<vector<u8>>, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg4 > arg3 && arg3 > 0x2::clock::timestamp_ms(arg0), 4200);
        let v0 = AirdropVault{
            id                    : 0x2::object::new(arg5),
            merkle_tree_roots     : arg2,
            hive_available        : 0x2::balance::zero<0xac914b6678503487e43280ec674f997bd9894b81c0dd428c4783bdda38b938d7::hive::HIVE>(),
            users_claimed_table   : 0x2::table::new<address, u64>(arg5),
            total_airdrop_amt     : 0,
            total_delegated_amt   : 0,
            total_withdrawn_amt   : 0,
            claim_start_timestamp : arg3,
            claim_end_timestamp   : arg4,
            withdrawals_allowed   : false,
        };
        0x2::transfer::share_object<AirdropVault>(v0);
    }

    public fun is_proof_valid(arg0: &AirdropVault, arg1: address, arg2: u64, arg3: vector<vector<u8>>, arg4: u64) : bool {
        0xb3b54baa1d1a8671640d4c40f0c678847da00416691a0ec7d4c975ba1380323c::merkle_proof::verify(&arg3, *0x1::vector::borrow<vector<u8>>(&arg0.merkle_tree_roots, arg4), create_leaf(arg1, arg2))
    }

    public entry fun transfer_unclaimed_tokens(arg0: &0x2::clock::Clock, arg1: &mut AirdropVault, arg2: &mut 0xac914b6678503487e43280ec674f997bd9894b81c0dd428c4783bdda38b938d7::hive::HiveVault, arg3: &mut 0xf99260f5a6d66df46ca77fba5b7bc986821243eb6c429b477cae0eae10b4218a::config::GemsTreasury, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::clock::timestamp_ms(arg0) > arg1.claim_end_timestamp, 4206);
        let v0 = 0x2::balance::value<0xac914b6678503487e43280ec674f997bd9894b81c0dd428c4783bdda38b938d7::hive::HIVE>(&arg1.hive_available);
        arg1.total_airdrop_amt = arg1.total_airdrop_amt - v0;
        let (v1, v2) = 0xac914b6678503487e43280ec674f997bd9894b81c0dd428c4783bdda38b938d7::hive::burn_hive_and_return_gems(arg2, 0x2::balance::withdraw_all<0xac914b6678503487e43280ec674f997bd9894b81c0dd428c4783bdda38b938d7::hive::HIVE>(&mut arg1.hive_available), v0, arg4);
        0x2::balance::destroy_zero<0xac914b6678503487e43280ec674f997bd9894b81c0dd428c4783bdda38b938d7::hive::HIVE>(v1);
        0xf99260f5a6d66df46ca77fba5b7bc986821243eb6c429b477cae0eae10b4218a::hive_gems::destroy_zero(0xf99260f5a6d66df46ca77fba5b7bc986821243eb6c429b477cae0eae10b4218a::config::deposit_gems_to_treasury(arg3, v2, v0));
    }

    public fun undelegate_hive_for_auction(arg0: &0xf99260f5a6d66df46ca77fba5b7bc986821243eb6c429b477cae0eae10b4218a::config::AuctionCapability, arg1: &mut AirdropVault, arg2: &mut HiveAirdropHolder, arg3: 0x2::balance::Balance<0xac914b6678503487e43280ec674f997bd9894b81c0dd428c4783bdda38b938d7::hive::HIVE>) {
        arg1.total_delegated_amt = arg1.total_delegated_amt - 0x2::balance::value<0xac914b6678503487e43280ec674f997bd9894b81c0dd428c4783bdda38b938d7::hive::HIVE>(&arg3);
        0x2::balance::join<0xac914b6678503487e43280ec674f997bd9894b81c0dd428c4783bdda38b938d7::hive::HIVE>(&mut arg2.hive_claimed, arg3);
    }

    public entry fun update_airdrop_vault(arg0: &AirdropAdminCapability, arg1: &mut AirdropVault, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 > arg1.claim_end_timestamp, 4200);
        arg1.claim_end_timestamp = arg2;
    }

    public entry fun withdraw_hive_airdrop(arg0: &mut AirdropVault, arg1: &mut 0xac914b6678503487e43280ec674f997bd9894b81c0dd428c4783bdda38b938d7::hive::HiveVault, arg2: &mut 0xac914b6678503487e43280ec674f997bd9894b81c0dd428c4783bdda38b938d7::hive_profile::HiveProfile, arg3: HiveAirdropHolder, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(arg0.withdrawals_allowed, 4205);
        let (v1, v2, _, v4) = 0xac914b6678503487e43280ec674f997bd9894b81c0dd428c4783bdda38b938d7::hive_profile::get_profile_meta_info(arg2);
        assert!(v4 == v0, 4207);
        let HiveAirdropHolder {
            id           : v5,
            hive_claimed : v6,
        } = arg3;
        let v7 = v6;
        0x2::object::delete(v5);
        let v8 = 0x2::balance::value<0xac914b6678503487e43280ec674f997bd9894b81c0dd428c4783bdda38b938d7::hive::HIVE>(&v7);
        arg0.total_withdrawn_amt = arg0.total_withdrawn_amt + v8;
        let v9 = AirdropUnlocked{
            recipient    : v0,
            profile_addr : v1,
            username     : v2,
            amount       : v8,
        };
        0x2::event::emit<AirdropUnlocked>(v9);
        0x2::balance::destroy_zero<0xac914b6678503487e43280ec674f997bd9894b81c0dd428c4783bdda38b938d7::hive::HIVE>(0xac914b6678503487e43280ec674f997bd9894b81c0dd428c4783bdda38b938d7::hive::burn_hive_and_return(arg1, arg2, v7, v8, arg4));
    }

    // decompiled from Move bytecode v6
}

