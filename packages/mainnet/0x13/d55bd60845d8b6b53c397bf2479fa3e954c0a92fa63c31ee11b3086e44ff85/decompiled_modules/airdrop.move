module 0x13d55bd60845d8b6b53c397bf2479fa3e954c0a92fa63c31ee11b3086e44ff85::airdrop {
    struct AirdropVault has store, key {
        id: 0x2::object::UID,
        claim_start_timestamp: u64,
        claim_end_timestamp: u64,
        withdrawals_allowed: bool,
        merkle_tree_roots: vector<vector<u8>>,
        hive_available: 0x2::balance::Balance<0x93230f1c985c9449f97ca81e7ee264da5290da0ba06f305762eb7e8bb4fa9272::hive::HIVE>,
        total_airdrop_amt: u64,
        user_profile_access_cap: 0x93230f1c985c9449f97ca81e7ee264da5290da0ba06f305762eb7e8bb4fa9272::hive_profile::ProfileDofOwnershipCapability,
        users_onboarded_map: 0x2::linked_table::LinkedTable<address, u64>,
        total_infused_amt: u64,
        total_withdrawn_amt: u64,
    }

    struct HiveAirdropHolder has store, key {
        id: 0x2::object::UID,
        hive_claimed: 0x2::balance::Balance<0x93230f1c985c9449f97ca81e7ee264da5290da0ba06f305762eb7e8bb4fa9272::hive::HIVE>,
    }

    struct AirdropClaimed has copy, drop {
        username: 0x1::string::String,
        profile_addr: address,
        recipient: address,
        amount: u64,
    }

    struct AirdropUnlocked has copy, drop {
        recipient: address,
        profile_addr: address,
        username: 0x1::string::String,
        amount: u64,
    }

    public entry fun add_hive_for_airdrop(arg0: &0x2::clock::Clock, arg1: &0x93230f1c985c9449f97ca81e7ee264da5290da0ba06f305762eb7e8bb4fa9272::hive_profile::AdminDofOwnershipCapability, arg2: &mut 0x93230f1c985c9449f97ca81e7ee264da5290da0ba06f305762eb7e8bb4fa9272::hive_profile::HiveManager, arg3: 0x2::coin::Coin<0x93230f1c985c9449f97ca81e7ee264da5290da0ba06f305762eb7e8bb4fa9272::hive::HIVE>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x93230f1c985c9449f97ca81e7ee264da5290da0ba06f305762eb7e8bb4fa9272::hive_profile::entry_manager_borrow_mut_from_profile<AirdropVault>(arg1, arg2);
        let v1 = 0x2::coin::into_balance<0x93230f1c985c9449f97ca81e7ee264da5290da0ba06f305762eb7e8bb4fa9272::hive::HIVE>(arg3);
        0x2::balance::join<0x93230f1c985c9449f97ca81e7ee264da5290da0ba06f305762eb7e8bb4fa9272::hive::HIVE>(&mut v0.hive_available, 0x2::balance::split<0x93230f1c985c9449f97ca81e7ee264da5290da0ba06f305762eb7e8bb4fa9272::hive::HIVE>(&mut v1, arg4));
        v0.total_airdrop_amt = v0.total_airdrop_amt + arg4;
        let v2 = 0x2::tx_context::sender(arg5);
        destroy_or_transfer_balance<0x93230f1c985c9449f97ca81e7ee264da5290da0ba06f305762eb7e8bb4fa9272::hive::HIVE>(v1, v2, arg5);
    }

    public entry fun claim_hive_airdrop(arg0: &0x93230f1c985c9449f97ca81e7ee264da5290da0ba06f305762eb7e8bb4fa9272::hive_profile::AdminDofOwnershipCapability, arg1: &0x2::clock::Clock, arg2: &mut 0x93230f1c985c9449f97ca81e7ee264da5290da0ba06f305762eb7e8bb4fa9272::hive_profile::HiveManager, arg3: &mut 0x93230f1c985c9449f97ca81e7ee264da5290da0ba06f305762eb7e8bb4fa9272::hive_profile::HiveProfile, arg4: u64, arg5: vector<vector<u8>>, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x93230f1c985c9449f97ca81e7ee264da5290da0ba06f305762eb7e8bb4fa9272::hive_profile::entry_manager_borrow_mut_from_profile<AirdropVault>(arg0, arg2);
        0x2::clock::timestamp_ms(arg1);
        let (v1, v2, _, v4) = 0x93230f1c985c9449f97ca81e7ee264da5290da0ba06f305762eb7e8bb4fa9272::hive_profile::get_profile_meta_info(arg3);
        assert!(v4 == 0x2::tx_context::sender(arg7), 4207);
        assert!(0x13d55bd60845d8b6b53c397bf2479fa3e954c0a92fa63c31ee11b3086e44ff85::merkle_proof::verify(&arg5, *0x1::vector::borrow<vector<u8>>(&v0.merkle_tree_roots, arg6), create_leaf(v4, arg4)), 4203);
        0x2::linked_table::push_back<address, u64>(&mut v0.users_onboarded_map, v4, arg4);
        let v5 = HiveAirdropHolder{
            id           : 0x2::object::new(arg7),
            hive_claimed : 0x2::balance::split<0x93230f1c985c9449f97ca81e7ee264da5290da0ba06f305762eb7e8bb4fa9272::hive::HIVE>(&mut v0.hive_available, arg4),
        };
        0x93230f1c985c9449f97ca81e7ee264da5290da0ba06f305762eb7e8bb4fa9272::hive_profile::entry_add_to_profile<HiveAirdropHolder>(&v0.user_profile_access_cap, arg3, v5, arg7);
        let v6 = AirdropClaimed{
            username     : v2,
            profile_addr : v1,
            recipient    : v4,
            amount       : arg4,
        };
        0x2::event::emit<AirdropClaimed>(v6);
    }

    fun create_leaf(arg0: address, arg1: u64) : vector<u8> {
        let v0 = 0x2::address::to_bytes(arg0);
        let v1 = 0x2::bcs::new(0x2::bcs::to_bytes<u64>(&arg1));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::peel_vec_u8(&mut v1));
        0x1::hash::sha2_256(v0)
    }

    public fun delegate_hive_for_infusion(arg0: &0x93230f1c985c9449f97ca81e7ee264da5290da0ba06f305762eb7e8bb4fa9272::hive_profile::AdminDofOwnershipCapability, arg1: &mut 0x93230f1c985c9449f97ca81e7ee264da5290da0ba06f305762eb7e8bb4fa9272::hive_profile::HiveManager, arg2: &mut 0x93230f1c985c9449f97ca81e7ee264da5290da0ba06f305762eb7e8bb4fa9272::hive_profile::HiveProfile, arg3: u64, arg4: &0x2::tx_context::TxContext) : 0x2::balance::Balance<0x93230f1c985c9449f97ca81e7ee264da5290da0ba06f305762eb7e8bb4fa9272::hive::HIVE> {
        let v0 = 0x93230f1c985c9449f97ca81e7ee264da5290da0ba06f305762eb7e8bb4fa9272::hive_profile::entry_manager_borrow_mut_from_profile<AirdropVault>(arg0, arg1);
        v0.total_infused_amt = v0.total_infused_amt + arg3;
        0x2::balance::split<0x93230f1c985c9449f97ca81e7ee264da5290da0ba06f305762eb7e8bb4fa9272::hive::HIVE>(&mut 0x93230f1c985c9449f97ca81e7ee264da5290da0ba06f305762eb7e8bb4fa9272::hive_profile::entry_borrow_mut_from_profile<HiveAirdropHolder>(&v0.user_profile_access_cap, arg2, arg4).hive_claimed, arg3)
    }

    fun destroy_or_transfer_balance<T0>(arg0: 0x2::balance::Balance<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        if (0x2::balance::value<T0>(&arg0) == 0) {
            0x2::balance::destroy_zero<T0>(arg0);
            return
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(arg0, arg2), arg1);
    }

    public fun enable_hive_withdrawals(arg0: &0x93230f1c985c9449f97ca81e7ee264da5290da0ba06f305762eb7e8bb4fa9272::hive_profile::AdminDofOwnershipCapability, arg1: &mut 0x93230f1c985c9449f97ca81e7ee264da5290da0ba06f305762eb7e8bb4fa9272::hive_profile::HiveManager) {
        0x93230f1c985c9449f97ca81e7ee264da5290da0ba06f305762eb7e8bb4fa9272::hive_profile::entry_manager_borrow_mut_from_profile<AirdropVault>(arg0, arg1).withdrawals_allowed = true;
    }

    public fun get_airdrop_vault(arg0: &0x93230f1c985c9449f97ca81e7ee264da5290da0ba06f305762eb7e8bb4fa9272::hive_profile::HiveManager) : (u64, u64, u64, u64, u64, u64, bool) {
        let v0 = 0x93230f1c985c9449f97ca81e7ee264da5290da0ba06f305762eb7e8bb4fa9272::hive_profile::borrow_from_admin_profile<AirdropVault>(arg0, 0x1::string::to_ascii(0x1::string::utf8(b"HIVE_AIRDROP_CAP")));
        (0x2::balance::value<0x93230f1c985c9449f97ca81e7ee264da5290da0ba06f305762eb7e8bb4fa9272::hive::HIVE>(&v0.hive_available), v0.total_airdrop_amt, v0.total_infused_amt, v0.total_withdrawn_amt, v0.claim_start_timestamp, v0.claim_end_timestamp, v0.withdrawals_allowed)
    }

    public fun has_user_claimed(arg0: &0x93230f1c985c9449f97ca81e7ee264da5290da0ba06f305762eb7e8bb4fa9272::hive_profile::HiveManager, arg1: address) : (bool, u64) {
        let v0 = 0x93230f1c985c9449f97ca81e7ee264da5290da0ba06f305762eb7e8bb4fa9272::hive_profile::borrow_from_admin_profile<AirdropVault>(arg0, 0x1::string::to_ascii(0x1::string::utf8(b"HIVE_AIRDROP_CAP")));
        if (0x2::linked_table::contains<address, u64>(&v0.users_onboarded_map, arg1)) {
            (true, *0x2::linked_table::borrow<address, u64>(&v0.users_onboarded_map, arg1))
        } else {
            (false, 0)
        }
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
    }

    public entry fun initialize_airdrop_vault(arg0: &0x2::clock::Clock, arg1: &0x93230f1c985c9449f97ca81e7ee264da5290da0ba06f305762eb7e8bb4fa9272::hive_profile::AdminDofOwnershipCapability, arg2: 0x93230f1c985c9449f97ca81e7ee264da5290da0ba06f305762eb7e8bb4fa9272::hive_profile::ProfileDofOwnershipCapability, arg3: &mut 0x93230f1c985c9449f97ca81e7ee264da5290da0ba06f305762eb7e8bb4fa9272::hive_profile::HiveManager, arg4: vector<vector<u8>>, arg5: u64, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        0x2::clock::timestamp_ms(arg0);
        let v0 = AirdropVault{
            id                      : 0x2::object::new(arg7),
            claim_start_timestamp   : arg5,
            claim_end_timestamp     : arg6,
            withdrawals_allowed     : false,
            merkle_tree_roots       : arg4,
            hive_available          : 0x2::balance::zero<0x93230f1c985c9449f97ca81e7ee264da5290da0ba06f305762eb7e8bb4fa9272::hive::HIVE>(),
            total_airdrop_amt       : 0,
            user_profile_access_cap : arg2,
            users_onboarded_map     : 0x2::linked_table::new<address, u64>(arg7),
            total_infused_amt       : 0,
            total_withdrawn_amt     : 0,
        };
        0x93230f1c985c9449f97ca81e7ee264da5290da0ba06f305762eb7e8bb4fa9272::hive_profile::entry_manager_add_to_profile<AirdropVault>(arg1, arg3, v0);
    }

    public fun is_proof_valid(arg0: &0x93230f1c985c9449f97ca81e7ee264da5290da0ba06f305762eb7e8bb4fa9272::hive_profile::HiveManager, arg1: address, arg2: u64, arg3: vector<vector<u8>>, arg4: u64) : bool {
        0x13d55bd60845d8b6b53c397bf2479fa3e954c0a92fa63c31ee11b3086e44ff85::merkle_proof::verify(&arg3, *0x1::vector::borrow<vector<u8>>(&0x93230f1c985c9449f97ca81e7ee264da5290da0ba06f305762eb7e8bb4fa9272::hive_profile::borrow_from_admin_profile<AirdropVault>(arg0, 0x1::string::to_ascii(0x1::string::utf8(b"HIVE_AIRDROP_CAP"))).merkle_tree_roots, arg4), create_leaf(arg1, arg2))
    }

    public fun query_airdrop_claimers(arg0: &0x93230f1c985c9449f97ca81e7ee264da5290da0ba06f305762eb7e8bb4fa9272::hive_profile::HiveManager, arg1: 0x1::option::Option<address>, arg2: u64) : (vector<address>, vector<u64>, u64) {
        let v0 = 0x93230f1c985c9449f97ca81e7ee264da5290da0ba06f305762eb7e8bb4fa9272::hive_profile::borrow_from_admin_profile<AirdropVault>(arg0, 0x1::string::to_ascii(0x1::string::utf8(b"HIVE_AIRDROP_CAP")));
        let v1 = 0x1::vector::empty<address>();
        let v2 = 0x1::vector::empty<u64>();
        let v3 = if (0x1::option::is_some<address>(&arg1)) {
            arg1
        } else {
            *0x2::linked_table::front<address, u64>(&v0.users_onboarded_map)
        };
        let v4 = v3;
        let v5 = 0;
        while (0x1::option::is_some<address>(&v4) && v5 < arg2) {
            let v6 = *0x1::option::borrow<address>(&v4);
            0x1::vector::push_back<address>(&mut v1, v6);
            0x1::vector::push_back<u64>(&mut v2, *0x2::linked_table::borrow<address, u64>(&v0.users_onboarded_map, v6));
            v4 = *0x2::linked_table::next<address, u64>(&v0.users_onboarded_map, v6);
            v5 = v5 + 1;
        };
        (v1, v2, 0x2::linked_table::length<address, u64>(&v0.users_onboarded_map))
    }

    public fun transfer_unclaimed_hive(arg0: &0x93230f1c985c9449f97ca81e7ee264da5290da0ba06f305762eb7e8bb4fa9272::hive_profile::AdminDofOwnershipCapability, arg1: &0x2::clock::Clock, arg2: &mut 0x93230f1c985c9449f97ca81e7ee264da5290da0ba06f305762eb7e8bb4fa9272::hive_profile::HiveManager, arg3: &mut 0x93230f1c985c9449f97ca81e7ee264da5290da0ba06f305762eb7e8bb4fa9272::hive::HiveVault, arg4: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = 0x93230f1c985c9449f97ca81e7ee264da5290da0ba06f305762eb7e8bb4fa9272::hive_profile::entry_manager_borrow_mut_from_profile<AirdropVault>(arg0, arg2);
        0x2::clock::timestamp_ms(arg1);
        let v1 = 0x2::balance::value<0x93230f1c985c9449f97ca81e7ee264da5290da0ba06f305762eb7e8bb4fa9272::hive::HIVE>(&v0.hive_available);
        v0.total_airdrop_amt = v0.total_airdrop_amt - v1;
        0x93230f1c985c9449f97ca81e7ee264da5290da0ba06f305762eb7e8bb4fa9272::hive_profile::deposit_gems_with_manager_profile(arg2, 0x93230f1c985c9449f97ca81e7ee264da5290da0ba06f305762eb7e8bb4fa9272::hive::burn_hive_and_return_gems(arg3, 0x2::balance::withdraw_all<0x93230f1c985c9449f97ca81e7ee264da5290da0ba06f305762eb7e8bb4fa9272::hive::HIVE>(&mut v0.hive_available), 0x2::object::uid_to_address(&v0.id), arg4));
        v1
    }

    public entry fun update_airdrop_vault(arg0: &0x93230f1c985c9449f97ca81e7ee264da5290da0ba06f305762eb7e8bb4fa9272::hive_profile::AdminDofOwnershipCapability, arg1: &mut 0x93230f1c985c9449f97ca81e7ee264da5290da0ba06f305762eb7e8bb4fa9272::hive_profile::HiveManager, arg2: vector<vector<u8>>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x93230f1c985c9449f97ca81e7ee264da5290da0ba06f305762eb7e8bb4fa9272::hive_profile::entry_manager_borrow_mut_from_profile<AirdropVault>(arg0, arg1);
        v0.claim_end_timestamp = arg3;
        v0.merkle_tree_roots = arg2;
    }

    public fun withdraw_hive_airdrop(arg0: &0x93230f1c985c9449f97ca81e7ee264da5290da0ba06f305762eb7e8bb4fa9272::hive_profile::AdminDofOwnershipCapability, arg1: &mut 0x93230f1c985c9449f97ca81e7ee264da5290da0ba06f305762eb7e8bb4fa9272::hive_profile::HiveManager, arg2: &mut 0x93230f1c985c9449f97ca81e7ee264da5290da0ba06f305762eb7e8bb4fa9272::hive::HiveVault, arg3: &mut 0x93230f1c985c9449f97ca81e7ee264da5290da0ba06f305762eb7e8bb4fa9272::hive_profile::HiveProfile, arg4: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = 0x93230f1c985c9449f97ca81e7ee264da5290da0ba06f305762eb7e8bb4fa9272::hive_profile::entry_manager_borrow_mut_from_profile<AirdropVault>(arg0, arg1);
        let v1 = 0x2::tx_context::sender(arg4);
        assert!(v0.withdrawals_allowed, 4205);
        let (v2, v3, _, v5) = 0x93230f1c985c9449f97ca81e7ee264da5290da0ba06f305762eb7e8bb4fa9272::hive_profile::get_profile_meta_info(arg3);
        assert!(v5 == v1, 4207);
        let HiveAirdropHolder {
            id           : v6,
            hive_claimed : v7,
        } = 0x93230f1c985c9449f97ca81e7ee264da5290da0ba06f305762eb7e8bb4fa9272::hive_profile::entry_remove_from_profile<HiveAirdropHolder>(&v0.user_profile_access_cap, arg3, arg4);
        let v8 = v7;
        0x2::object::delete(v6);
        let v9 = 0x2::balance::value<0x93230f1c985c9449f97ca81e7ee264da5290da0ba06f305762eb7e8bb4fa9272::hive::HIVE>(&v8);
        v0.total_withdrawn_amt = v0.total_withdrawn_amt + v9;
        let v10 = AirdropUnlocked{
            recipient    : v1,
            profile_addr : v2,
            username     : v3,
            amount       : v9,
        };
        0x2::event::emit<AirdropUnlocked>(v10);
        0x2::balance::destroy_zero<0x93230f1c985c9449f97ca81e7ee264da5290da0ba06f305762eb7e8bb4fa9272::hive::HIVE>(0x93230f1c985c9449f97ca81e7ee264da5290da0ba06f305762eb7e8bb4fa9272::hive::burn_hive_and_return(arg2, arg3, v8, v9, arg4));
        v9
    }

    // decompiled from Move bytecode v6
}

