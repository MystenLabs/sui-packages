module 0xd9f7c381adf27c52b74d3be56998aea8c723ef1d73cf1d1a7a9a7fbdb7fdc5c::airdrop {
    struct AirdropVault has store, key {
        id: 0x2::object::UID,
        claim_start_timestamp: u64,
        claim_end_timestamp: u64,
        withdrawals_allowed: bool,
        merkle_tree_roots: vector<0x1::string::String>,
        hive_available: 0x2::balance::Balance<0x249a788a31d9c48bda91536ff9d9396ec473b7d168d13f99e8788ca31e130e6f::hive::HIVE>,
        total_airdrop_amt: u64,
        user_profile_access_cap: 0x249a788a31d9c48bda91536ff9d9396ec473b7d168d13f99e8788ca31e130e6f::hive_profile::ProfileDofOwnershipCapability,
        users_onboarded_map: 0x2::linked_table::LinkedTable<address, u64>,
        total_infused_amt: u64,
        total_withdrawn_amt: u64,
    }

    struct HiveAirdropHolder has store, key {
        id: 0x2::object::UID,
        hive_claimed: 0x2::balance::Balance<0x249a788a31d9c48bda91536ff9d9396ec473b7d168d13f99e8788ca31e130e6f::hive::HIVE>,
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

    public entry fun add_hive_for_airdrop(arg0: &0x2::clock::Clock, arg1: &0x249a788a31d9c48bda91536ff9d9396ec473b7d168d13f99e8788ca31e130e6f::hive_profile::AdminDofOwnershipCapability, arg2: &mut 0x249a788a31d9c48bda91536ff9d9396ec473b7d168d13f99e8788ca31e130e6f::hive_profile::HiveManager, arg3: 0x2::coin::Coin<0x249a788a31d9c48bda91536ff9d9396ec473b7d168d13f99e8788ca31e130e6f::hive::HIVE>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x249a788a31d9c48bda91536ff9d9396ec473b7d168d13f99e8788ca31e130e6f::hive_profile::entry_manager_borrow_mut_from_profile<AirdropVault>(arg1, arg2);
        assert!(0x2::clock::timestamp_ms(arg0) < v0.claim_end_timestamp, 4201);
        let v1 = 0x2::coin::into_balance<0x249a788a31d9c48bda91536ff9d9396ec473b7d168d13f99e8788ca31e130e6f::hive::HIVE>(arg3);
        0x2::balance::join<0x249a788a31d9c48bda91536ff9d9396ec473b7d168d13f99e8788ca31e130e6f::hive::HIVE>(&mut v0.hive_available, 0x2::balance::split<0x249a788a31d9c48bda91536ff9d9396ec473b7d168d13f99e8788ca31e130e6f::hive::HIVE>(&mut v1, arg4));
        v0.total_airdrop_amt = v0.total_airdrop_amt + arg4;
        let v2 = 0x2::tx_context::sender(arg5);
        destroy_or_transfer_balance<0x249a788a31d9c48bda91536ff9d9396ec473b7d168d13f99e8788ca31e130e6f::hive::HIVE>(v1, v2, arg5);
    }

    public entry fun claim_hive_airdrop(arg0: &0x249a788a31d9c48bda91536ff9d9396ec473b7d168d13f99e8788ca31e130e6f::hive_profile::AdminDofOwnershipCapability, arg1: &0x2::clock::Clock, arg2: &mut 0x249a788a31d9c48bda91536ff9d9396ec473b7d168d13f99e8788ca31e130e6f::hive_profile::HiveManager, arg3: &mut 0x249a788a31d9c48bda91536ff9d9396ec473b7d168d13f99e8788ca31e130e6f::hive_profile::HiveProfile, arg4: u64, arg5: vector<0x1::string::String>, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x249a788a31d9c48bda91536ff9d9396ec473b7d168d13f99e8788ca31e130e6f::hive_profile::entry_manager_borrow_mut_from_profile<AirdropVault>(arg0, arg2);
        let v1 = 0x2::clock::timestamp_ms(arg1);
        assert!(v1 < v0.claim_end_timestamp && v1 >= v0.claim_start_timestamp, 4202);
        let (v2, v3, _, v5) = 0x249a788a31d9c48bda91536ff9d9396ec473b7d168d13f99e8788ca31e130e6f::hive_profile::get_profile_meta_info(arg3);
        assert!(v5 == 0x2::tx_context::sender(arg7), 4207);
        assert!(0xd9f7c381adf27c52b74d3be56998aea8c723ef1d73cf1d1a7a9a7fbdb7fdc5c::merkle_proof::verify(&arg5, *0x1::vector::borrow<0x1::string::String>(&v0.merkle_tree_roots, arg6), create_leaf(v5, arg4)), 4203);
        assert!(!0x2::linked_table::contains<address, u64>(&v0.users_onboarded_map, v5), 4204);
        0x2::linked_table::push_back<address, u64>(&mut v0.users_onboarded_map, v5, arg4);
        let v6 = HiveAirdropHolder{
            id           : 0x2::object::new(arg7),
            hive_claimed : 0x2::balance::split<0x249a788a31d9c48bda91536ff9d9396ec473b7d168d13f99e8788ca31e130e6f::hive::HIVE>(&mut v0.hive_available, arg4),
        };
        0x249a788a31d9c48bda91536ff9d9396ec473b7d168d13f99e8788ca31e130e6f::hive_profile::entry_add_to_profile<HiveAirdropHolder>(&v0.user_profile_access_cap, arg3, v6, arg7);
        let v7 = AirdropClaimed{
            username     : v3,
            profile_addr : v2,
            recipient    : v5,
            amount       : arg4,
        };
        0x2::event::emit<AirdropClaimed>(v7);
    }

    fun create_leaf(arg0: address, arg1: u64) : vector<u8> {
        let v0 = 0x2::address::to_string(arg0);
        0x1::string::append(&mut v0, 0x1::string::utf8(0x4414b96a690c02eafcdfc974cf733aa44f5e541fab35e4919808213156d9f660::coin_helper::u64_to_ascii(arg1)));
        0x1::hash::sha2_256(*0x1::string::bytes(&v0))
    }

    public fun delegate_hive_for_infusion(arg0: &0x249a788a31d9c48bda91536ff9d9396ec473b7d168d13f99e8788ca31e130e6f::hive_profile::AdminDofOwnershipCapability, arg1: &mut 0x249a788a31d9c48bda91536ff9d9396ec473b7d168d13f99e8788ca31e130e6f::hive_profile::HiveManager, arg2: &mut 0x249a788a31d9c48bda91536ff9d9396ec473b7d168d13f99e8788ca31e130e6f::hive_profile::HiveProfile, arg3: u64, arg4: &0x2::tx_context::TxContext) : 0x2::balance::Balance<0x249a788a31d9c48bda91536ff9d9396ec473b7d168d13f99e8788ca31e130e6f::hive::HIVE> {
        let v0 = 0x249a788a31d9c48bda91536ff9d9396ec473b7d168d13f99e8788ca31e130e6f::hive_profile::entry_manager_borrow_mut_from_profile<AirdropVault>(arg0, arg1);
        v0.total_infused_amt = v0.total_infused_amt + arg3;
        0x2::balance::split<0x249a788a31d9c48bda91536ff9d9396ec473b7d168d13f99e8788ca31e130e6f::hive::HIVE>(&mut 0x249a788a31d9c48bda91536ff9d9396ec473b7d168d13f99e8788ca31e130e6f::hive_profile::entry_borrow_mut_from_profile<HiveAirdropHolder>(&v0.user_profile_access_cap, arg2, arg4).hive_claimed, arg3)
    }

    fun destroy_or_transfer_balance<T0>(arg0: 0x2::balance::Balance<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        if (0x2::balance::value<T0>(&arg0) == 0) {
            0x2::balance::destroy_zero<T0>(arg0);
            return
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(arg0, arg2), arg1);
    }

    public fun enable_hive_withdrawals(arg0: &0x249a788a31d9c48bda91536ff9d9396ec473b7d168d13f99e8788ca31e130e6f::hive_profile::AdminDofOwnershipCapability, arg1: &mut 0x249a788a31d9c48bda91536ff9d9396ec473b7d168d13f99e8788ca31e130e6f::hive_profile::HiveManager) {
        0x249a788a31d9c48bda91536ff9d9396ec473b7d168d13f99e8788ca31e130e6f::hive_profile::entry_manager_borrow_mut_from_profile<AirdropVault>(arg0, arg1).withdrawals_allowed = true;
    }

    public fun get_airdrop_vault(arg0: &0x249a788a31d9c48bda91536ff9d9396ec473b7d168d13f99e8788ca31e130e6f::hive_profile::HiveManager) : (u64, u64, u64, u64, u64, u64, bool) {
        let v0 = 0x249a788a31d9c48bda91536ff9d9396ec473b7d168d13f99e8788ca31e130e6f::hive_profile::borrow_from_admin_profile<AirdropVault>(arg0, 0x1::string::to_ascii(0x1::string::utf8(b"HIVE_AIRDROP_CAP")));
        (0x2::balance::value<0x249a788a31d9c48bda91536ff9d9396ec473b7d168d13f99e8788ca31e130e6f::hive::HIVE>(&v0.hive_available), v0.total_airdrop_amt, v0.total_infused_amt, v0.total_withdrawn_amt, v0.claim_start_timestamp, v0.claim_end_timestamp, v0.withdrawals_allowed)
    }

    public fun has_user_claimed(arg0: &0x249a788a31d9c48bda91536ff9d9396ec473b7d168d13f99e8788ca31e130e6f::hive_profile::HiveManager, arg1: address) : (bool, u64) {
        let v0 = 0x249a788a31d9c48bda91536ff9d9396ec473b7d168d13f99e8788ca31e130e6f::hive_profile::borrow_from_admin_profile<AirdropVault>(arg0, 0x1::string::to_ascii(0x1::string::utf8(b"HIVE_AIRDROP_CAP")));
        if (0x2::linked_table::contains<address, u64>(&v0.users_onboarded_map, arg1)) {
            (true, *0x2::linked_table::borrow<address, u64>(&v0.users_onboarded_map, arg1))
        } else {
            (false, 0)
        }
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
    }

    public entry fun initialize_airdrop_vault(arg0: &0x2::clock::Clock, arg1: &0x249a788a31d9c48bda91536ff9d9396ec473b7d168d13f99e8788ca31e130e6f::hive_profile::AdminDofOwnershipCapability, arg2: 0x249a788a31d9c48bda91536ff9d9396ec473b7d168d13f99e8788ca31e130e6f::hive_profile::ProfileDofOwnershipCapability, arg3: &mut 0x249a788a31d9c48bda91536ff9d9396ec473b7d168d13f99e8788ca31e130e6f::hive_profile::HiveManager, arg4: vector<0x1::string::String>, arg5: u64, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(arg6 > arg5 && arg5 > 0x2::clock::timestamp_ms(arg0), 4200);
        let v0 = AirdropVault{
            id                      : 0x2::object::new(arg7),
            claim_start_timestamp   : arg5,
            claim_end_timestamp     : arg6,
            withdrawals_allowed     : false,
            merkle_tree_roots       : arg4,
            hive_available          : 0x2::balance::zero<0x249a788a31d9c48bda91536ff9d9396ec473b7d168d13f99e8788ca31e130e6f::hive::HIVE>(),
            total_airdrop_amt       : 0,
            user_profile_access_cap : arg2,
            users_onboarded_map     : 0x2::linked_table::new<address, u64>(arg7),
            total_infused_amt       : 0,
            total_withdrawn_amt     : 0,
        };
        0x249a788a31d9c48bda91536ff9d9396ec473b7d168d13f99e8788ca31e130e6f::hive_profile::entry_manager_add_to_profile<AirdropVault>(arg1, arg3, v0);
    }

    public fun is_proof_valid(arg0: &0x249a788a31d9c48bda91536ff9d9396ec473b7d168d13f99e8788ca31e130e6f::hive_profile::HiveManager, arg1: address, arg2: u64, arg3: vector<0x1::string::String>, arg4: u64) : bool {
        0xd9f7c381adf27c52b74d3be56998aea8c723ef1d73cf1d1a7a9a7fbdb7fdc5c::merkle_proof::verify(&arg3, *0x1::vector::borrow<0x1::string::String>(&0x249a788a31d9c48bda91536ff9d9396ec473b7d168d13f99e8788ca31e130e6f::hive_profile::borrow_from_admin_profile<AirdropVault>(arg0, 0x1::string::to_ascii(0x1::string::utf8(b"HIVE_AIRDROP_CAP"))).merkle_tree_roots, arg4), create_leaf(arg1, arg2))
    }

    public fun query_airdrop_claimers(arg0: &0x249a788a31d9c48bda91536ff9d9396ec473b7d168d13f99e8788ca31e130e6f::hive_profile::HiveManager, arg1: 0x1::option::Option<address>, arg2: u64) : (vector<address>, vector<u64>, u64) {
        let v0 = 0x249a788a31d9c48bda91536ff9d9396ec473b7d168d13f99e8788ca31e130e6f::hive_profile::borrow_from_admin_profile<AirdropVault>(arg0, 0x1::string::to_ascii(0x1::string::utf8(b"HIVE_AIRDROP_CAP")));
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

    public fun transfer_unclaimed_hive(arg0: &0x249a788a31d9c48bda91536ff9d9396ec473b7d168d13f99e8788ca31e130e6f::hive_profile::AdminDofOwnershipCapability, arg1: &0x2::clock::Clock, arg2: &mut 0x249a788a31d9c48bda91536ff9d9396ec473b7d168d13f99e8788ca31e130e6f::hive_profile::HiveManager, arg3: &mut 0x249a788a31d9c48bda91536ff9d9396ec473b7d168d13f99e8788ca31e130e6f::hive::HiveVault, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x249a788a31d9c48bda91536ff9d9396ec473b7d168d13f99e8788ca31e130e6f::hive_profile::entry_manager_borrow_mut_from_profile<AirdropVault>(arg0, arg2);
        assert!(0x2::clock::timestamp_ms(arg1) > v0.claim_end_timestamp, 4206);
        v0.total_airdrop_amt = v0.total_airdrop_amt - 0x2::balance::value<0x249a788a31d9c48bda91536ff9d9396ec473b7d168d13f99e8788ca31e130e6f::hive::HIVE>(&v0.hive_available);
        0x249a788a31d9c48bda91536ff9d9396ec473b7d168d13f99e8788ca31e130e6f::hive_profile::deposit_gems_with_manager_profile(arg2, 0x249a788a31d9c48bda91536ff9d9396ec473b7d168d13f99e8788ca31e130e6f::hive::burn_hive_and_return_gems(arg3, 0x2::balance::withdraw_all<0x249a788a31d9c48bda91536ff9d9396ec473b7d168d13f99e8788ca31e130e6f::hive::HIVE>(&mut v0.hive_available), 0x2::object::uid_to_address(&v0.id), arg4));
    }

    public entry fun update_airdrop_vault(arg0: &0x249a788a31d9c48bda91536ff9d9396ec473b7d168d13f99e8788ca31e130e6f::hive_profile::AdminDofOwnershipCapability, arg1: &mut 0x249a788a31d9c48bda91536ff9d9396ec473b7d168d13f99e8788ca31e130e6f::hive_profile::HiveManager, arg2: vector<0x1::string::String>, arg3: u64, arg4: &0x2::tx_context::TxContext) {
        let v0 = 0x249a788a31d9c48bda91536ff9d9396ec473b7d168d13f99e8788ca31e130e6f::hive_profile::entry_manager_borrow_mut_from_profile<AirdropVault>(arg0, arg1);
        assert!(arg3 > v0.claim_end_timestamp, 4200);
        v0.claim_end_timestamp = arg3;
        v0.merkle_tree_roots = arg2;
    }

    public fun withdraw_hive_airdrop(arg0: &0x249a788a31d9c48bda91536ff9d9396ec473b7d168d13f99e8788ca31e130e6f::hive_profile::AdminDofOwnershipCapability, arg1: &mut 0x249a788a31d9c48bda91536ff9d9396ec473b7d168d13f99e8788ca31e130e6f::hive_profile::HiveManager, arg2: &mut 0x249a788a31d9c48bda91536ff9d9396ec473b7d168d13f99e8788ca31e130e6f::hive::HiveVault, arg3: &mut 0x249a788a31d9c48bda91536ff9d9396ec473b7d168d13f99e8788ca31e130e6f::hive_profile::HiveProfile, arg4: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = 0x249a788a31d9c48bda91536ff9d9396ec473b7d168d13f99e8788ca31e130e6f::hive_profile::entry_manager_borrow_mut_from_profile<AirdropVault>(arg0, arg1);
        let v1 = 0x2::tx_context::sender(arg4);
        assert!(v0.withdrawals_allowed, 4205);
        let (v2, v3, _, v5) = 0x249a788a31d9c48bda91536ff9d9396ec473b7d168d13f99e8788ca31e130e6f::hive_profile::get_profile_meta_info(arg3);
        assert!(v5 == v1, 4207);
        let HiveAirdropHolder {
            id           : v6,
            hive_claimed : v7,
        } = 0x249a788a31d9c48bda91536ff9d9396ec473b7d168d13f99e8788ca31e130e6f::hive_profile::entry_remove_from_profile<HiveAirdropHolder>(&v0.user_profile_access_cap, arg3, arg4);
        let v8 = v7;
        0x2::object::delete(v6);
        let v9 = 0x2::balance::value<0x249a788a31d9c48bda91536ff9d9396ec473b7d168d13f99e8788ca31e130e6f::hive::HIVE>(&v8);
        v0.total_withdrawn_amt = v0.total_withdrawn_amt + v9;
        let v10 = AirdropUnlocked{
            recipient    : v1,
            profile_addr : v2,
            username     : v3,
            amount       : v9,
        };
        0x2::event::emit<AirdropUnlocked>(v10);
        0x2::balance::destroy_zero<0x249a788a31d9c48bda91536ff9d9396ec473b7d168d13f99e8788ca31e130e6f::hive::HIVE>(0x249a788a31d9c48bda91536ff9d9396ec473b7d168d13f99e8788ca31e130e6f::hive::burn_hive_and_return(arg2, arg3, v8, v9, arg4));
        v9
    }

    // decompiled from Move bytecode v6
}

