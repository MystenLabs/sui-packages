module 0x6810f5568936a9a2b5fcb043f59a3cbf681e06f0db61c90bf3ff5530d4f470c0::dvn {
    struct SetDstConfigEvent has copy, drop {
        dvn: address,
        dst_eid: u32,
        gas: u256,
        multiplier_bps: u16,
        floor_margin_usd: u128,
    }

    struct DVN has store, key {
        id: 0x2::object::UID,
        vid: u32,
        worker: 0x6b29b0abf9da88be53a9ea1dfab8f600930b9ab6961eee65d67c1eecdd8cb695::worker_common::Worker,
        dst_configs: 0x2::table::Table<u32, DstConfig>,
        multisig: 0x6810f5568936a9a2b5fcb043f59a3cbf681e06f0db61c90bf3ff5530d4f470c0::multisig::MultiSig,
        used_hashes: 0x2::table::Table<0xcdad05867c25d6461e5813071116fa3f26d56a9b52ad053747457efb79d45714::bytes32::Bytes32, bool>,
        owner_cap: 0x6b29b0abf9da88be53a9ea1dfab8f600930b9ab6961eee65d67c1eecdd8cb695::worker_common::OwnerCap,
        ptb_builder_initialized: bool,
    }

    struct DstConfig has copy, drop, store {
        gas: u256,
        multiplier_bps: u16,
        floor_margin_usd: u128,
    }

    public fun admin_cap_id(arg0: &DVN, arg1: address) : address {
        0x6b29b0abf9da88be53a9ea1dfab8f600930b9ab6961eee65d67c1eecdd8cb695::worker_common::get_admin_cap_id(&arg0.worker, arg1)
    }

    public fun admins(arg0: &DVN) : 0x2::vec_set::VecSet<address> {
        0x6b29b0abf9da88be53a9ea1dfab8f600930b9ab6961eee65d67c1eecdd8cb695::worker_common::admins(&arg0.worker)
    }

    public fun allowlist_size(arg0: &DVN) : u64 {
        0x6b29b0abf9da88be53a9ea1dfab8f600930b9ab6961eee65d67c1eecdd8cb695::worker_common::allowlist_size(&arg0.worker)
    }

    fun assert_all_and_add_to_history(arg0: &mut DVN, arg1: &vector<u8>, arg2: u64, arg3: vector<u8>, arg4: &0x2::clock::Clock) {
        assert!(arg2 > 0x2::clock::timestamp_ms(arg4) / 1000, 1);
        let v0 = 0xcdad05867c25d6461e5813071116fa3f26d56a9b52ad053747457efb79d45714::bytes32::from_bytes(0x2::hash::keccak256(&arg3));
        assert!(!0x2::table::contains<0xcdad05867c25d6461e5813071116fa3f26d56a9b52ad053747457efb79d45714::bytes32::Bytes32, bool>(&arg0.used_hashes, v0), 3);
        0x6810f5568936a9a2b5fcb043f59a3cbf681e06f0db61c90bf3ff5530d4f470c0::multisig::assert_signatures_verified(&arg0.multisig, arg3, arg1);
        0x2::table::add<0xcdad05867c25d6461e5813071116fa3f26d56a9b52ad053747457efb79d45714::bytes32::Bytes32, bool>(&mut arg0.used_hashes, v0, true);
    }

    public fun assign_job(arg0: &DVN, arg1: &mut 0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::multi_call::MultiCall<0xd73c9d588717c32fa327335d9beaf59b983b808577a382e013d8c7161a323d8e::dvn_assign_job::AssignJobParam, 0x5ccc92487b6d38cf5e327c8c5178776d48dbf82020f25b2f766dcf3dfd669752::fee_recipient::FeeRecipient>, arg2: &mut 0x2::tx_context::TxContext) : 0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call::Call<0x52a3df1246c964666c7d8918332d470202a9166f5f4cdc9f452cd2c2ff40136::dvn_feelib_get_fee::FeelibGetFeeParam, u64> {
        let v0 = 0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::multi_call::borrow_mut<0xd73c9d588717c32fa327335d9beaf59b983b808577a382e013d8c7161a323d8e::dvn_assign_job::AssignJobParam, 0x5ccc92487b6d38cf5e327c8c5178776d48dbf82020f25b2f766dcf3dfd669752::fee_recipient::FeeRecipient>(arg1, 0x6b29b0abf9da88be53a9ea1dfab8f600930b9ab6961eee65d67c1eecdd8cb695::worker_common::worker_cap(&arg0.worker));
        let v1 = *0xd73c9d588717c32fa327335d9beaf59b983b808577a382e013d8c7161a323d8e::dvn_assign_job::base(0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call::param<0xd73c9d588717c32fa327335d9beaf59b983b808577a382e013d8c7161a323d8e::dvn_assign_job::AssignJobParam, 0x5ccc92487b6d38cf5e327c8c5178776d48dbf82020f25b2f766dcf3dfd669752::fee_recipient::FeeRecipient>(v0));
        create_feelib_get_fee_call<0xd73c9d588717c32fa327335d9beaf59b983b808577a382e013d8c7161a323d8e::dvn_assign_job::AssignJobParam, 0x5ccc92487b6d38cf5e327c8c5178776d48dbf82020f25b2f766dcf3dfd669752::fee_recipient::FeeRecipient>(arg0, v0, v1, arg2)
    }

    public fun confirm_assign_job(arg0: &DVN, arg1: &mut 0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::multi_call::MultiCall<0xd73c9d588717c32fa327335d9beaf59b983b808577a382e013d8c7161a323d8e::dvn_assign_job::AssignJobParam, 0x5ccc92487b6d38cf5e327c8c5178776d48dbf82020f25b2f766dcf3dfd669752::fee_recipient::FeeRecipient>, arg2: 0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call::Call<0x52a3df1246c964666c7d8918332d470202a9166f5f4cdc9f452cd2c2ff40136::dvn_feelib_get_fee::FeelibGetFeeParam, u64>) {
        let v0 = 0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::multi_call::borrow_mut<0xd73c9d588717c32fa327335d9beaf59b983b808577a382e013d8c7161a323d8e::dvn_assign_job::AssignJobParam, 0x5ccc92487b6d38cf5e327c8c5178776d48dbf82020f25b2f766dcf3dfd669752::fee_recipient::FeeRecipient>(arg1, 0x6b29b0abf9da88be53a9ea1dfab8f600930b9ab6961eee65d67c1eecdd8cb695::worker_common::worker_cap(&arg0.worker));
        let (_, _, v3) = 0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call::destroy_child<0xd73c9d588717c32fa327335d9beaf59b983b808577a382e013d8c7161a323d8e::dvn_assign_job::AssignJobParam, 0x5ccc92487b6d38cf5e327c8c5178776d48dbf82020f25b2f766dcf3dfd669752::fee_recipient::FeeRecipient, 0x52a3df1246c964666c7d8918332d470202a9166f5f4cdc9f452cd2c2ff40136::dvn_feelib_get_fee::FeelibGetFeeParam, u64>(v0, 0x6b29b0abf9da88be53a9ea1dfab8f600930b9ab6961eee65d67c1eecdd8cb695::worker_common::worker_cap(&arg0.worker), arg2);
        0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call::complete<0xd73c9d588717c32fa327335d9beaf59b983b808577a382e013d8c7161a323d8e::dvn_assign_job::AssignJobParam, 0x5ccc92487b6d38cf5e327c8c5178776d48dbf82020f25b2f766dcf3dfd669752::fee_recipient::FeeRecipient>(v0, 0x6b29b0abf9da88be53a9ea1dfab8f600930b9ab6961eee65d67c1eecdd8cb695::worker_common::worker_cap(&arg0.worker), 0x5ccc92487b6d38cf5e327c8c5178776d48dbf82020f25b2f766dcf3dfd669752::fee_recipient::create(v3, 0x6b29b0abf9da88be53a9ea1dfab8f600930b9ab6961eee65d67c1eecdd8cb695::worker_common::deposit_address(&arg0.worker)));
    }

    public fun confirm_get_fee(arg0: &DVN, arg1: &mut 0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::multi_call::MultiCall<0xd73c9d588717c32fa327335d9beaf59b983b808577a382e013d8c7161a323d8e::dvn_get_fee::GetFeeParam, u64>, arg2: 0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call::Call<0x52a3df1246c964666c7d8918332d470202a9166f5f4cdc9f452cd2c2ff40136::dvn_feelib_get_fee::FeelibGetFeeParam, u64>) {
        let v0 = 0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::multi_call::borrow_mut<0xd73c9d588717c32fa327335d9beaf59b983b808577a382e013d8c7161a323d8e::dvn_get_fee::GetFeeParam, u64>(arg1, 0x6b29b0abf9da88be53a9ea1dfab8f600930b9ab6961eee65d67c1eecdd8cb695::worker_common::worker_cap(&arg0.worker));
        let (_, _, v3) = 0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call::destroy_child<0xd73c9d588717c32fa327335d9beaf59b983b808577a382e013d8c7161a323d8e::dvn_get_fee::GetFeeParam, u64, 0x52a3df1246c964666c7d8918332d470202a9166f5f4cdc9f452cd2c2ff40136::dvn_feelib_get_fee::FeelibGetFeeParam, u64>(v0, 0x6b29b0abf9da88be53a9ea1dfab8f600930b9ab6961eee65d67c1eecdd8cb695::worker_common::worker_cap(&arg0.worker), arg2);
        0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call::complete<0xd73c9d588717c32fa327335d9beaf59b983b808577a382e013d8c7161a323d8e::dvn_get_fee::GetFeeParam, u64>(v0, 0x6b29b0abf9da88be53a9ea1dfab8f600930b9ab6961eee65d67c1eecdd8cb695::worker_common::worker_cap(&arg0.worker), v3);
    }

    public fun create_dvn(arg0: 0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call_cap::CallCap, arg1: u32, arg2: address, arg3: address, arg4: address, arg5: u16, arg6: vector<address>, arg7: vector<vector<u8>>, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) : DVN {
        let (v0, v1) = 0x6b29b0abf9da88be53a9ea1dfab8f600930b9ab6961eee65d67c1eecdd8cb695::worker_common::create_worker(arg0, arg2, arg3, arg4, arg5, arg6, arg9);
        DVN{
            id                      : 0x2::object::new(arg9),
            vid                     : arg1,
            worker                  : v0,
            dst_configs             : 0x2::table::new<u32, DstConfig>(arg9),
            multisig                : 0x6810f5568936a9a2b5fcb043f59a3cbf681e06f0db61c90bf3ff5530d4f470c0::multisig::new(arg7, arg8),
            used_hashes             : 0x2::table::new<0xcdad05867c25d6461e5813071116fa3f26d56a9b52ad053747457efb79d45714::bytes32::Bytes32, bool>(arg9),
            owner_cap               : v1,
            ptb_builder_initialized : false,
        }
    }

    fun create_feelib_get_fee_call<T0, T1>(arg0: &DVN, arg1: &mut 0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call::Call<T0, T1>, arg2: 0xd73c9d588717c32fa327335d9beaf59b983b808577a382e013d8c7161a323d8e::dvn_get_fee::GetFeeParam, arg3: &mut 0x2::tx_context::TxContext) : 0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call::Call<0x52a3df1246c964666c7d8918332d470202a9166f5f4cdc9f452cd2c2ff40136::dvn_feelib_get_fee::FeelibGetFeeParam, u64> {
        0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call::assert_caller<T0, T1>(arg1, 0xcdad05867c25d6461e5813071116fa3f26d56a9b52ad053747457efb79d45714::package::original_package_of_type<0xd73c9d588717c32fa327335d9beaf59b983b808577a382e013d8c7161a323d8e::uln_302::ULN_302>());
        0x6b29b0abf9da88be53a9ea1dfab8f600930b9ab6961eee65d67c1eecdd8cb695::worker_common::assert_acl(&arg0.worker, 0xd73c9d588717c32fa327335d9beaf59b983b808577a382e013d8c7161a323d8e::dvn_get_fee::sender(&arg2));
        0x6b29b0abf9da88be53a9ea1dfab8f600930b9ab6961eee65d67c1eecdd8cb695::worker_common::assert_worker_unpaused(&arg0.worker);
        let v0 = dst_config(arg0, 0xd73c9d588717c32fa327335d9beaf59b983b808577a382e013d8c7161a323d8e::dvn_get_fee::dst_eid(&arg2));
        0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call::create_single_child<T0, T1, 0x52a3df1246c964666c7d8918332d470202a9166f5f4cdc9f452cd2c2ff40136::dvn_feelib_get_fee::FeelibGetFeeParam, u64>(arg1, 0x6b29b0abf9da88be53a9ea1dfab8f600930b9ab6961eee65d67c1eecdd8cb695::worker_common::worker_cap(&arg0.worker), 0x6b29b0abf9da88be53a9ea1dfab8f600930b9ab6961eee65d67c1eecdd8cb695::worker_common::worker_fee_lib(&arg0.worker), 0x52a3df1246c964666c7d8918332d470202a9166f5f4cdc9f452cd2c2ff40136::dvn_feelib_get_fee::create_param(0xd73c9d588717c32fa327335d9beaf59b983b808577a382e013d8c7161a323d8e::dvn_get_fee::sender(&arg2), 0xd73c9d588717c32fa327335d9beaf59b983b808577a382e013d8c7161a323d8e::dvn_get_fee::dst_eid(&arg2), 0xd73c9d588717c32fa327335d9beaf59b983b808577a382e013d8c7161a323d8e::dvn_get_fee::confirmations(&arg2), *0xd73c9d588717c32fa327335d9beaf59b983b808577a382e013d8c7161a323d8e::dvn_get_fee::options(&arg2), 0x6810f5568936a9a2b5fcb043f59a3cbf681e06f0db61c90bf3ff5530d4f470c0::multisig::quorum(&arg0.multisig), 0x6b29b0abf9da88be53a9ea1dfab8f600930b9ab6961eee65d67c1eecdd8cb695::worker_common::price_feed(&arg0.worker), 0x6b29b0abf9da88be53a9ea1dfab8f600930b9ab6961eee65d67c1eecdd8cb695::worker_common::default_multiplier_bps(&arg0.worker), v0.gas, v0.multiplier_bps, v0.floor_margin_usd), arg3)
    }

    public fun default_multiplier_bps(arg0: &DVN) : u16 {
        0x6b29b0abf9da88be53a9ea1dfab8f600930b9ab6961eee65d67c1eecdd8cb695::worker_common::default_multiplier_bps(&arg0.worker)
    }

    public fun deposit_address(arg0: &DVN) : address {
        0x6b29b0abf9da88be53a9ea1dfab8f600930b9ab6961eee65d67c1eecdd8cb695::worker_common::deposit_address(&arg0.worker)
    }

    public fun dst_config(arg0: &DVN, arg1: u32) : DstConfig {
        assert!(0x2::table::contains<u32, DstConfig>(&arg0.dst_configs, arg1), 2);
        *0x2::table::borrow<u32, DstConfig>(&arg0.dst_configs, arg1)
    }

    public fun get_fee(arg0: &DVN, arg1: &mut 0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::multi_call::MultiCall<0xd73c9d588717c32fa327335d9beaf59b983b808577a382e013d8c7161a323d8e::dvn_get_fee::GetFeeParam, u64>, arg2: &mut 0x2::tx_context::TxContext) : 0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call::Call<0x52a3df1246c964666c7d8918332d470202a9166f5f4cdc9f452cd2c2ff40136::dvn_feelib_get_fee::FeelibGetFeeParam, u64> {
        let v0 = 0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::multi_call::borrow_mut<0xd73c9d588717c32fa327335d9beaf59b983b808577a382e013d8c7161a323d8e::dvn_get_fee::GetFeeParam, u64>(arg1, 0x6b29b0abf9da88be53a9ea1dfab8f600930b9ab6961eee65d67c1eecdd8cb695::worker_common::worker_cap(&arg0.worker));
        let v1 = *0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call::param<0xd73c9d588717c32fa327335d9beaf59b983b808577a382e013d8c7161a323d8e::dvn_get_fee::GetFeeParam, u64>(v0);
        create_feelib_get_fee_call<0xd73c9d588717c32fa327335d9beaf59b983b808577a382e013d8c7161a323d8e::dvn_get_fee::GetFeeParam, u64>(arg0, v0, v1, arg2)
    }

    public fun has_acl(arg0: &DVN, arg1: address) : bool {
        0x6b29b0abf9da88be53a9ea1dfab8f600930b9ab6961eee65d67c1eecdd8cb695::worker_common::has_acl(&arg0.worker, arg1)
    }

    public fun init_ptb_builder_move_calls(arg0: &mut DVN, arg1: &0x6b29b0abf9da88be53a9ea1dfab8f600930b9ab6961eee65d67c1eecdd8cb695::worker_common::AdminCap, arg2: address, arg3: vector<0xdd38c96b282271279247c26dba1f51d6e45209396a9e548154881e04549db66::move_call::MoveCall>, arg4: vector<0xdd38c96b282271279247c26dba1f51d6e45209396a9e548154881e04549db66::move_call::MoveCall>, arg5: &mut 0x2::tx_context::TxContext) : 0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call::Call<0xea847a7eee0e55f52a121829cc6ede9603649a39290e6d46566e9206d5e9761f::set_worker_ptb::SetWorkerPtbParam, 0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call::Void> {
        assert!(!arg0.ptb_builder_initialized, 4);
        set_ptb_builder_move_calls_internal(arg0, arg1, arg2, arg3, arg4, arg5)
    }

    public fun is_admin(arg0: &DVN, arg1: &0x6b29b0abf9da88be53a9ea1dfab8f600930b9ab6961eee65d67c1eecdd8cb695::worker_common::AdminCap) : bool {
        0x6b29b0abf9da88be53a9ea1dfab8f600930b9ab6961eee65d67c1eecdd8cb695::worker_common::is_admin(&arg0.worker, arg1)
    }

    public fun is_admin_address(arg0: &DVN, arg1: address) : bool {
        0x6b29b0abf9da88be53a9ea1dfab8f600930b9ab6961eee65d67c1eecdd8cb695::worker_common::is_admin_address(&arg0.worker, arg1)
    }

    public fun is_allowlisted(arg0: &DVN, arg1: address) : bool {
        0x6b29b0abf9da88be53a9ea1dfab8f600930b9ab6961eee65d67c1eecdd8cb695::worker_common::is_on_allowlist(&arg0.worker, arg1)
    }

    public fun is_denylisted(arg0: &DVN, arg1: address) : bool {
        0x6b29b0abf9da88be53a9ea1dfab8f600930b9ab6961eee65d67c1eecdd8cb695::worker_common::is_on_denylist(&arg0.worker, arg1)
    }

    public fun is_paused(arg0: &DVN) : bool {
        0x6b29b0abf9da88be53a9ea1dfab8f600930b9ab6961eee65d67c1eecdd8cb695::worker_common::is_paused(&arg0.worker)
    }

    public fun is_ptb_builder_initialized(arg0: &DVN) : bool {
        arg0.ptb_builder_initialized
    }

    public fun is_signer(arg0: &DVN, arg1: vector<u8>) : bool {
        0x6810f5568936a9a2b5fcb043f59a3cbf681e06f0db61c90bf3ff5530d4f470c0::multisig::is_signer(&arg0.multisig, arg1)
    }

    public fun price_feed(arg0: &DVN) : address {
        0x6b29b0abf9da88be53a9ea1dfab8f600930b9ab6961eee65d67c1eecdd8cb695::worker_common::price_feed(&arg0.worker)
    }

    public fun quorum(arg0: &DVN) : u64 {
        0x6810f5568936a9a2b5fcb043f59a3cbf681e06f0db61c90bf3ff5530d4f470c0::multisig::quorum(&arg0.multisig)
    }

    public fun quorum_change_admin(arg0: &mut DVN, arg1: address, arg2: bool, arg3: u64, arg4: vector<u8>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x6810f5568936a9a2b5fcb043f59a3cbf681e06f0db61c90bf3ff5530d4f470c0::hashes::build_quorum_change_admin_payload(arg1, arg2, arg0.vid, arg3);
        assert_all_and_add_to_history(arg0, &arg4, arg3, v0, arg5);
        0x6b29b0abf9da88be53a9ea1dfab8f600930b9ab6961eee65d67c1eecdd8cb695::worker_common::set_admin(&mut arg0.worker, &arg0.owner_cap, arg1, arg2, arg6);
    }

    public fun set_admin(arg0: &mut DVN, arg1: &0x6b29b0abf9da88be53a9ea1dfab8f600930b9ab6961eee65d67c1eecdd8cb695::worker_common::AdminCap, arg2: address, arg3: bool, arg4: &mut 0x2::tx_context::TxContext) {
        0x6b29b0abf9da88be53a9ea1dfab8f600930b9ab6961eee65d67c1eecdd8cb695::worker_common::assert_admin(&arg0.worker, arg1);
        0x6b29b0abf9da88be53a9ea1dfab8f600930b9ab6961eee65d67c1eecdd8cb695::worker_common::set_admin(&mut arg0.worker, &arg0.owner_cap, arg2, arg3, arg4);
    }

    public fun set_allowlist(arg0: &mut DVN, arg1: &0x6b29b0abf9da88be53a9ea1dfab8f600930b9ab6961eee65d67c1eecdd8cb695::worker_common::AdminCap, arg2: address, arg3: bool, arg4: u64, arg5: vector<u8>, arg6: &0x2::clock::Clock) {
        0x6b29b0abf9da88be53a9ea1dfab8f600930b9ab6961eee65d67c1eecdd8cb695::worker_common::assert_admin(&arg0.worker, arg1);
        let v0 = 0x6810f5568936a9a2b5fcb043f59a3cbf681e06f0db61c90bf3ff5530d4f470c0::hashes::build_set_allowlist_payload(arg2, arg3, arg0.vid, arg4);
        assert_all_and_add_to_history(arg0, &arg5, arg4, v0, arg6);
        0x6b29b0abf9da88be53a9ea1dfab8f600930b9ab6961eee65d67c1eecdd8cb695::worker_common::set_allowlist(&mut arg0.worker, &arg0.owner_cap, arg2, arg3);
    }

    public fun set_default_multiplier_bps(arg0: &mut DVN, arg1: &0x6b29b0abf9da88be53a9ea1dfab8f600930b9ab6961eee65d67c1eecdd8cb695::worker_common::AdminCap, arg2: u16) {
        0x6b29b0abf9da88be53a9ea1dfab8f600930b9ab6961eee65d67c1eecdd8cb695::worker_common::set_default_multiplier_bps(&mut arg0.worker, arg1, arg2);
    }

    public fun set_denylist(arg0: &mut DVN, arg1: &0x6b29b0abf9da88be53a9ea1dfab8f600930b9ab6961eee65d67c1eecdd8cb695::worker_common::AdminCap, arg2: address, arg3: bool, arg4: u64, arg5: vector<u8>, arg6: &0x2::clock::Clock) {
        0x6b29b0abf9da88be53a9ea1dfab8f600930b9ab6961eee65d67c1eecdd8cb695::worker_common::assert_admin(&arg0.worker, arg1);
        let v0 = 0x6810f5568936a9a2b5fcb043f59a3cbf681e06f0db61c90bf3ff5530d4f470c0::hashes::build_set_denylist_payload(arg2, arg3, arg0.vid, arg4);
        assert_all_and_add_to_history(arg0, &arg5, arg4, v0, arg6);
        0x6b29b0abf9da88be53a9ea1dfab8f600930b9ab6961eee65d67c1eecdd8cb695::worker_common::set_denylist(&mut arg0.worker, &arg0.owner_cap, arg2, arg3);
    }

    public fun set_deposit_address(arg0: &mut DVN, arg1: &0x6b29b0abf9da88be53a9ea1dfab8f600930b9ab6961eee65d67c1eecdd8cb695::worker_common::AdminCap, arg2: address) {
        0x6b29b0abf9da88be53a9ea1dfab8f600930b9ab6961eee65d67c1eecdd8cb695::worker_common::set_deposit_address(&mut arg0.worker, arg1, arg2);
    }

    public fun set_dst_config(arg0: &mut DVN, arg1: &0x6b29b0abf9da88be53a9ea1dfab8f600930b9ab6961eee65d67c1eecdd8cb695::worker_common::AdminCap, arg2: u32, arg3: u256, arg4: u16, arg5: u128) {
        0x6b29b0abf9da88be53a9ea1dfab8f600930b9ab6961eee65d67c1eecdd8cb695::worker_common::assert_admin(&arg0.worker, arg1);
        let v0 = DstConfig{
            gas              : arg3,
            multiplier_bps   : arg4,
            floor_margin_usd : arg5,
        };
        let v1 = &mut arg0.dst_configs;
        if (0x2::table::contains<u32, DstConfig>(v1, arg2)) {
            *0x2::table::borrow_mut<u32, DstConfig>(v1, arg2) = v0;
        } else {
            0x2::table::add<u32, DstConfig>(v1, arg2, v0);
        };
        let v2 = SetDstConfigEvent{
            dvn              : 0x6b29b0abf9da88be53a9ea1dfab8f600930b9ab6961eee65d67c1eecdd8cb695::worker_common::worker_cap_address(&arg0.worker),
            dst_eid          : arg2,
            gas              : arg3,
            multiplier_bps   : arg4,
            floor_margin_usd : arg5,
        };
        0x2::event::emit<SetDstConfigEvent>(v2);
    }

    public fun set_dvn_signer(arg0: &mut DVN, arg1: &0x6b29b0abf9da88be53a9ea1dfab8f600930b9ab6961eee65d67c1eecdd8cb695::worker_common::AdminCap, arg2: vector<u8>, arg3: bool, arg4: u64, arg5: vector<u8>, arg6: &0x2::clock::Clock) {
        0x6b29b0abf9da88be53a9ea1dfab8f600930b9ab6961eee65d67c1eecdd8cb695::worker_common::assert_admin(&arg0.worker, arg1);
        let v0 = 0x6810f5568936a9a2b5fcb043f59a3cbf681e06f0db61c90bf3ff5530d4f470c0::hashes::build_set_dvn_signer_payload(arg2, arg3, arg0.vid, arg4);
        assert_all_and_add_to_history(arg0, &arg5, arg4, v0, arg6);
        0x6810f5568936a9a2b5fcb043f59a3cbf681e06f0db61c90bf3ff5530d4f470c0::multisig::set_signer(&mut arg0.multisig, worker_cap_address(arg0), arg2, arg3);
    }

    public fun set_paused(arg0: &mut DVN, arg1: &0x6b29b0abf9da88be53a9ea1dfab8f600930b9ab6961eee65d67c1eecdd8cb695::worker_common::AdminCap, arg2: bool, arg3: u64, arg4: vector<u8>, arg5: &0x2::clock::Clock) {
        0x6b29b0abf9da88be53a9ea1dfab8f600930b9ab6961eee65d67c1eecdd8cb695::worker_common::assert_admin(&arg0.worker, arg1);
        let v0 = 0x6810f5568936a9a2b5fcb043f59a3cbf681e06f0db61c90bf3ff5530d4f470c0::hashes::build_set_pause_payload(arg2, arg0.vid, arg3);
        assert_all_and_add_to_history(arg0, &arg4, arg3, v0, arg5);
        0x6b29b0abf9da88be53a9ea1dfab8f600930b9ab6961eee65d67c1eecdd8cb695::worker_common::set_paused(&mut arg0.worker, &arg0.owner_cap, arg2);
    }

    public fun set_price_feed(arg0: &mut DVN, arg1: &0x6b29b0abf9da88be53a9ea1dfab8f600930b9ab6961eee65d67c1eecdd8cb695::worker_common::AdminCap, arg2: address) {
        0x6b29b0abf9da88be53a9ea1dfab8f600930b9ab6961eee65d67c1eecdd8cb695::worker_common::set_price_feed(&mut arg0.worker, arg1, arg2);
    }

    public fun set_ptb_builder_move_calls(arg0: &mut DVN, arg1: &0x6b29b0abf9da88be53a9ea1dfab8f600930b9ab6961eee65d67c1eecdd8cb695::worker_common::AdminCap, arg2: address, arg3: vector<0xdd38c96b282271279247c26dba1f51d6e45209396a9e548154881e04549db66::move_call::MoveCall>, arg4: vector<0xdd38c96b282271279247c26dba1f51d6e45209396a9e548154881e04549db66::move_call::MoveCall>, arg5: u64, arg6: vector<u8>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : 0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call::Call<0xea847a7eee0e55f52a121829cc6ede9603649a39290e6d46566e9206d5e9761f::set_worker_ptb::SetWorkerPtbParam, 0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call::Void> {
        let v0 = 0x6810f5568936a9a2b5fcb043f59a3cbf681e06f0db61c90bf3ff5530d4f470c0::hashes::build_set_ptb_builder_move_calls_payload(arg2, arg3, arg4, arg0.vid, arg5);
        assert_all_and_add_to_history(arg0, &arg6, arg5, v0, arg7);
        set_ptb_builder_move_calls_internal(arg0, arg1, arg2, arg3, arg4, arg8)
    }

    fun set_ptb_builder_move_calls_internal(arg0: &mut DVN, arg1: &0x6b29b0abf9da88be53a9ea1dfab8f600930b9ab6961eee65d67c1eecdd8cb695::worker_common::AdminCap, arg2: address, arg3: vector<0xdd38c96b282271279247c26dba1f51d6e45209396a9e548154881e04549db66::move_call::MoveCall>, arg4: vector<0xdd38c96b282271279247c26dba1f51d6e45209396a9e548154881e04549db66::move_call::MoveCall>, arg5: &mut 0x2::tx_context::TxContext) : 0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call::Call<0xea847a7eee0e55f52a121829cc6ede9603649a39290e6d46566e9206d5e9761f::set_worker_ptb::SetWorkerPtbParam, 0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call::Void> {
        0x6b29b0abf9da88be53a9ea1dfab8f600930b9ab6961eee65d67c1eecdd8cb695::worker_common::assert_admin(&arg0.worker, arg1);
        arg0.ptb_builder_initialized = true;
        0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call::create<0xea847a7eee0e55f52a121829cc6ede9603649a39290e6d46566e9206d5e9761f::set_worker_ptb::SetWorkerPtbParam, 0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call::Void>(0x6b29b0abf9da88be53a9ea1dfab8f600930b9ab6961eee65d67c1eecdd8cb695::worker_common::worker_cap(&arg0.worker), arg2, true, 0xea847a7eee0e55f52a121829cc6ede9603649a39290e6d46566e9206d5e9761f::set_worker_ptb::create_param(arg3, arg4), arg5)
    }

    public fun set_quorum(arg0: &mut DVN, arg1: &0x6b29b0abf9da88be53a9ea1dfab8f600930b9ab6961eee65d67c1eecdd8cb695::worker_common::AdminCap, arg2: u64, arg3: u64, arg4: vector<u8>, arg5: &0x2::clock::Clock) {
        0x6b29b0abf9da88be53a9ea1dfab8f600930b9ab6961eee65d67c1eecdd8cb695::worker_common::assert_admin(&arg0.worker, arg1);
        let v0 = 0x6810f5568936a9a2b5fcb043f59a3cbf681e06f0db61c90bf3ff5530d4f470c0::hashes::build_set_quorum_payload(arg2, arg0.vid, arg3);
        assert_all_and_add_to_history(arg0, &arg4, arg3, v0, arg5);
        0x6810f5568936a9a2b5fcb043f59a3cbf681e06f0db61c90bf3ff5530d4f470c0::multisig::set_quorum(&mut arg0.multisig, worker_cap_address(arg0), arg2);
    }

    public fun set_supported_option_types(arg0: &mut DVN, arg1: &0x6b29b0abf9da88be53a9ea1dfab8f600930b9ab6961eee65d67c1eecdd8cb695::worker_common::AdminCap, arg2: u32, arg3: vector<u8>) {
        0x6b29b0abf9da88be53a9ea1dfab8f600930b9ab6961eee65d67c1eecdd8cb695::worker_common::set_supported_option_types(&mut arg0.worker, arg1, arg2, arg3);
    }

    public fun set_worker_fee_lib(arg0: &mut DVN, arg1: &0x6b29b0abf9da88be53a9ea1dfab8f600930b9ab6961eee65d67c1eecdd8cb695::worker_common::AdminCap, arg2: address) {
        0x6b29b0abf9da88be53a9ea1dfab8f600930b9ab6961eee65d67c1eecdd8cb695::worker_common::set_worker_fee_lib(&mut arg0.worker, arg1, arg2);
    }

    public fun signer_count(arg0: &DVN) : u64 {
        0x6810f5568936a9a2b5fcb043f59a3cbf681e06f0db61c90bf3ff5530d4f470c0::multisig::signer_count(&arg0.multisig)
    }

    public fun signers(arg0: &DVN) : vector<vector<u8>> {
        0x6810f5568936a9a2b5fcb043f59a3cbf681e06f0db61c90bf3ff5530d4f470c0::multisig::get_signers(&arg0.multisig)
    }

    public fun supported_option_types(arg0: &DVN, arg1: u32) : vector<u8> {
        0x6b29b0abf9da88be53a9ea1dfab8f600930b9ab6961eee65d67c1eecdd8cb695::worker_common::get_supported_option_types(&arg0.worker, arg1)
    }

    public fun verify(arg0: &mut DVN, arg1: &0x6b29b0abf9da88be53a9ea1dfab8f600930b9ab6961eee65d67c1eecdd8cb695::worker_common::AdminCap, arg2: &mut 0xd73c9d588717c32fa327335d9beaf59b983b808577a382e013d8c7161a323d8e::receive_uln::Verification, arg3: vector<u8>, arg4: 0xcdad05867c25d6461e5813071116fa3f26d56a9b52ad053747457efb79d45714::bytes32::Bytes32, arg5: u64, arg6: u64, arg7: vector<u8>, arg8: &0x2::clock::Clock) {
        0x6b29b0abf9da88be53a9ea1dfab8f600930b9ab6961eee65d67c1eecdd8cb695::worker_common::assert_admin(&arg0.worker, arg1);
        let v0 = 0x6810f5568936a9a2b5fcb043f59a3cbf681e06f0db61c90bf3ff5530d4f470c0::hashes::build_verify_payload(arg3, 0xcdad05867c25d6461e5813071116fa3f26d56a9b52ad053747457efb79d45714::bytes32::to_bytes(&arg4), arg5, 0xcdad05867c25d6461e5813071116fa3f26d56a9b52ad053747457efb79d45714::package::original_package_of_type<0xd73c9d588717c32fa327335d9beaf59b983b808577a382e013d8c7161a323d8e::uln_302::ULN_302>(), arg0.vid, arg6);
        assert_all_and_add_to_history(arg0, &arg7, arg6, v0, arg8);
        0xd73c9d588717c32fa327335d9beaf59b983b808577a382e013d8c7161a323d8e::uln_302::verify(arg2, 0x6b29b0abf9da88be53a9ea1dfab8f600930b9ab6961eee65d67c1eecdd8cb695::worker_common::worker_cap(&arg0.worker), arg3, arg4, arg5);
    }

    public fun vid(arg0: &DVN) : u32 {
        arg0.vid
    }

    public fun worker_cap_address(arg0: &DVN) : address {
        0x6b29b0abf9da88be53a9ea1dfab8f600930b9ab6961eee65d67c1eecdd8cb695::worker_common::worker_cap_address(&arg0.worker)
    }

    public fun worker_fee_lib(arg0: &DVN) : address {
        0x6b29b0abf9da88be53a9ea1dfab8f600930b9ab6961eee65d67c1eecdd8cb695::worker_common::worker_fee_lib(&arg0.worker)
    }

    // decompiled from Move bytecode v6
}

