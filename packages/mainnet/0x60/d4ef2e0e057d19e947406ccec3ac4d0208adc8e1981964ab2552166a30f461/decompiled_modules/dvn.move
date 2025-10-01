module 0x60d4ef2e0e057d19e947406ccec3ac4d0208adc8e1981964ab2552166a30f461::dvn {
    struct SetDstConfigEvent has copy, drop {
        dvn: address,
        dst_eid: u32,
        gas: u256,
        multiplier_bps: u16,
        floor_margin_usd: u128,
    }

    struct DVN has key {
        id: 0x2::object::UID,
        vid: u32,
        worker: 0x601523f0fbdb81de1cb79b24d001a8aa85b9a848c337d51ab815fb476630b86c::worker_common::Worker,
        dst_configs: 0x2::table::Table<u32, DstConfig>,
        multisig: 0x60d4ef2e0e057d19e947406ccec3ac4d0208adc8e1981964ab2552166a30f461::multisig::MultiSig,
        used_hashes: 0x2::table::Table<0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::Bytes32, bool>,
        owner_cap: 0x601523f0fbdb81de1cb79b24d001a8aa85b9a848c337d51ab815fb476630b86c::worker_common::OwnerCap,
        ptb_builder_initialized: bool,
    }

    struct DstConfig has copy, drop, store {
        gas: u256,
        multiplier_bps: u16,
        floor_margin_usd: u128,
    }

    public fun admins(arg0: &DVN) : 0x2::vec_set::VecSet<address> {
        0x601523f0fbdb81de1cb79b24d001a8aa85b9a848c337d51ab815fb476630b86c::worker_common::admins(&arg0.worker)
    }

    public fun allowlist_size(arg0: &DVN) : u64 {
        0x601523f0fbdb81de1cb79b24d001a8aa85b9a848c337d51ab815fb476630b86c::worker_common::allowlist_size(&arg0.worker)
    }

    public fun default_multiplier_bps(arg0: &DVN) : u16 {
        0x601523f0fbdb81de1cb79b24d001a8aa85b9a848c337d51ab815fb476630b86c::worker_common::default_multiplier_bps(&arg0.worker)
    }

    public fun deposit_address(arg0: &DVN) : address {
        0x601523f0fbdb81de1cb79b24d001a8aa85b9a848c337d51ab815fb476630b86c::worker_common::deposit_address(&arg0.worker)
    }

    public fun has_acl(arg0: &DVN, arg1: address) : bool {
        0x601523f0fbdb81de1cb79b24d001a8aa85b9a848c337d51ab815fb476630b86c::worker_common::has_acl(&arg0.worker, arg1)
    }

    public fun is_admin(arg0: &DVN, arg1: &0x601523f0fbdb81de1cb79b24d001a8aa85b9a848c337d51ab815fb476630b86c::worker_common::AdminCap) : bool {
        0x601523f0fbdb81de1cb79b24d001a8aa85b9a848c337d51ab815fb476630b86c::worker_common::is_admin(&arg0.worker, arg1)
    }

    public fun is_admin_address(arg0: &DVN, arg1: address) : bool {
        0x601523f0fbdb81de1cb79b24d001a8aa85b9a848c337d51ab815fb476630b86c::worker_common::is_admin_address(&arg0.worker, arg1)
    }

    public fun is_paused(arg0: &DVN) : bool {
        0x601523f0fbdb81de1cb79b24d001a8aa85b9a848c337d51ab815fb476630b86c::worker_common::is_paused(&arg0.worker)
    }

    public fun is_supported_message_lib(arg0: &DVN, arg1: address) : bool {
        0x601523f0fbdb81de1cb79b24d001a8aa85b9a848c337d51ab815fb476630b86c::worker_common::is_supported_message_lib(&arg0.worker, arg1)
    }

    public fun price_feed(arg0: &DVN) : address {
        0x601523f0fbdb81de1cb79b24d001a8aa85b9a848c337d51ab815fb476630b86c::worker_common::price_feed(&arg0.worker)
    }

    public fun set_admin(arg0: &mut DVN, arg1: &0x601523f0fbdb81de1cb79b24d001a8aa85b9a848c337d51ab815fb476630b86c::worker_common::AdminCap, arg2: address, arg3: bool, arg4: &mut 0x2::tx_context::TxContext) {
        0x601523f0fbdb81de1cb79b24d001a8aa85b9a848c337d51ab815fb476630b86c::worker_common::assert_admin(&arg0.worker, arg1);
        0x601523f0fbdb81de1cb79b24d001a8aa85b9a848c337d51ab815fb476630b86c::worker_common::set_admin(&mut arg0.worker, &arg0.owner_cap, arg2, arg3, arg4);
    }

    public fun set_allowlist(arg0: &mut DVN, arg1: &0x601523f0fbdb81de1cb79b24d001a8aa85b9a848c337d51ab815fb476630b86c::worker_common::AdminCap, arg2: address, arg3: bool, arg4: u64, arg5: vector<u8>, arg6: &0x2::clock::Clock) {
        0x601523f0fbdb81de1cb79b24d001a8aa85b9a848c337d51ab815fb476630b86c::worker_common::assert_admin(&arg0.worker, arg1);
        let v0 = 0x60d4ef2e0e057d19e947406ccec3ac4d0208adc8e1981964ab2552166a30f461::hashes::build_set_allowlist_payload(arg2, arg3, arg0.vid, arg4);
        assert_all_and_add_to_history(arg0, &arg5, arg4, v0, arg6);
        0x601523f0fbdb81de1cb79b24d001a8aa85b9a848c337d51ab815fb476630b86c::worker_common::set_allowlist(&mut arg0.worker, &arg0.owner_cap, arg2, arg3);
    }

    public fun set_default_multiplier_bps(arg0: &mut DVN, arg1: &0x601523f0fbdb81de1cb79b24d001a8aa85b9a848c337d51ab815fb476630b86c::worker_common::AdminCap, arg2: u16) {
        0x601523f0fbdb81de1cb79b24d001a8aa85b9a848c337d51ab815fb476630b86c::worker_common::set_default_multiplier_bps(&mut arg0.worker, arg1, arg2);
    }

    public fun set_denylist(arg0: &mut DVN, arg1: &0x601523f0fbdb81de1cb79b24d001a8aa85b9a848c337d51ab815fb476630b86c::worker_common::AdminCap, arg2: address, arg3: bool, arg4: u64, arg5: vector<u8>, arg6: &0x2::clock::Clock) {
        0x601523f0fbdb81de1cb79b24d001a8aa85b9a848c337d51ab815fb476630b86c::worker_common::assert_admin(&arg0.worker, arg1);
        let v0 = 0x60d4ef2e0e057d19e947406ccec3ac4d0208adc8e1981964ab2552166a30f461::hashes::build_set_denylist_payload(arg2, arg3, arg0.vid, arg4);
        assert_all_and_add_to_history(arg0, &arg5, arg4, v0, arg6);
        0x601523f0fbdb81de1cb79b24d001a8aa85b9a848c337d51ab815fb476630b86c::worker_common::set_denylist(&mut arg0.worker, &arg0.owner_cap, arg2, arg3);
    }

    public fun set_deposit_address(arg0: &mut DVN, arg1: &0x601523f0fbdb81de1cb79b24d001a8aa85b9a848c337d51ab815fb476630b86c::worker_common::AdminCap, arg2: address) {
        0x601523f0fbdb81de1cb79b24d001a8aa85b9a848c337d51ab815fb476630b86c::worker_common::set_deposit_address(&mut arg0.worker, arg1, arg2);
    }

    public fun set_paused(arg0: &mut DVN, arg1: &0x601523f0fbdb81de1cb79b24d001a8aa85b9a848c337d51ab815fb476630b86c::worker_common::AdminCap, arg2: bool, arg3: u64, arg4: vector<u8>, arg5: &0x2::clock::Clock) {
        0x601523f0fbdb81de1cb79b24d001a8aa85b9a848c337d51ab815fb476630b86c::worker_common::assert_admin(&arg0.worker, arg1);
        let v0 = 0x60d4ef2e0e057d19e947406ccec3ac4d0208adc8e1981964ab2552166a30f461::hashes::build_set_pause_payload(arg2, arg0.vid, arg3);
        assert_all_and_add_to_history(arg0, &arg4, arg3, v0, arg5);
        0x601523f0fbdb81de1cb79b24d001a8aa85b9a848c337d51ab815fb476630b86c::worker_common::set_paused(&mut arg0.worker, &arg0.owner_cap, arg2);
    }

    public fun set_price_feed(arg0: &mut DVN, arg1: &0x601523f0fbdb81de1cb79b24d001a8aa85b9a848c337d51ab815fb476630b86c::worker_common::AdminCap, arg2: address) {
        0x601523f0fbdb81de1cb79b24d001a8aa85b9a848c337d51ab815fb476630b86c::worker_common::set_price_feed(&mut arg0.worker, arg1, arg2);
    }

    public fun set_supported_message_lib(arg0: &mut DVN, arg1: &0x601523f0fbdb81de1cb79b24d001a8aa85b9a848c337d51ab815fb476630b86c::worker_common::AdminCap, arg2: address, arg3: bool, arg4: u64, arg5: vector<u8>, arg6: &0x2::clock::Clock) {
        0x601523f0fbdb81de1cb79b24d001a8aa85b9a848c337d51ab815fb476630b86c::worker_common::assert_admin(&arg0.worker, arg1);
        let v0 = 0x60d4ef2e0e057d19e947406ccec3ac4d0208adc8e1981964ab2552166a30f461::hashes::build_set_supported_message_lib_payload(arg2, arg3, arg0.vid, arg4);
        assert_all_and_add_to_history(arg0, &arg5, arg4, v0, arg6);
        0x601523f0fbdb81de1cb79b24d001a8aa85b9a848c337d51ab815fb476630b86c::worker_common::set_supported_message_lib(&mut arg0.worker, &arg0.owner_cap, arg2, arg3);
    }

    public fun set_supported_option_types(arg0: &mut DVN, arg1: &0x601523f0fbdb81de1cb79b24d001a8aa85b9a848c337d51ab815fb476630b86c::worker_common::AdminCap, arg2: u32, arg3: vector<u8>) {
        0x601523f0fbdb81de1cb79b24d001a8aa85b9a848c337d51ab815fb476630b86c::worker_common::set_supported_option_types(&mut arg0.worker, arg1, arg2, arg3);
    }

    public fun set_worker_fee_lib(arg0: &mut DVN, arg1: &0x601523f0fbdb81de1cb79b24d001a8aa85b9a848c337d51ab815fb476630b86c::worker_common::AdminCap, arg2: address) {
        0x601523f0fbdb81de1cb79b24d001a8aa85b9a848c337d51ab815fb476630b86c::worker_common::set_worker_fee_lib(&mut arg0.worker, arg1, arg2);
    }

    public fun worker_cap_address(arg0: &DVN) : address {
        0x601523f0fbdb81de1cb79b24d001a8aa85b9a848c337d51ab815fb476630b86c::worker_common::worker_cap_address(&arg0.worker)
    }

    public fun worker_fee_lib(arg0: &DVN) : address {
        0x601523f0fbdb81de1cb79b24d001a8aa85b9a848c337d51ab815fb476630b86c::worker_common::worker_fee_lib(&arg0.worker)
    }

    public fun admin_cap_id(arg0: &DVN, arg1: address) : address {
        0x601523f0fbdb81de1cb79b24d001a8aa85b9a848c337d51ab815fb476630b86c::worker_common::get_admin_cap_id(&arg0.worker, arg1)
    }

    fun assert_all_and_add_to_history(arg0: &mut DVN, arg1: &vector<u8>, arg2: u64, arg3: vector<u8>, arg4: &0x2::clock::Clock) {
        assert!(arg2 > 0x2::clock::timestamp_ms(arg4) / 1000, 1);
        let v0 = 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::from_bytes(0x2::hash::keccak256(&arg3));
        assert!(!0x2::table::contains<0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::Bytes32, bool>(&arg0.used_hashes, v0), 3);
        0x60d4ef2e0e057d19e947406ccec3ac4d0208adc8e1981964ab2552166a30f461::multisig::assert_signatures_verified(&arg0.multisig, arg3, arg1);
        0x2::table::add<0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::Bytes32, bool>(&mut arg0.used_hashes, v0, true);
    }

    public fun assign_job(arg0: &DVN, arg1: &mut 0xf00ed2e3fedf4a517c5ab2a2a52d985a127381d49bb24c8428b1f757846c5cdd::multi_call::MultiCall<0x51c7613a4cc7974057500e6bbbfb6e053fd807a6ab14aa7a2d8def233db19810::dvn_assign_job::AssignJobParam, 0x9de6d60206bfbc7b6f4c898b7d7c12dc749973098a9c346bca9d0cfa365be0d3::fee_recipient::FeeRecipient>, arg2: &mut 0x2::tx_context::TxContext) : 0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call::Call<0xdca981787d26a288b49d73b58aa8e7938022072b9ac6e8b843508ccfc0d8ac53::dvn_feelib_get_fee::FeelibGetFeeParam, u64> {
        let v0 = 0xf00ed2e3fedf4a517c5ab2a2a52d985a127381d49bb24c8428b1f757846c5cdd::multi_call::borrow_next<0x51c7613a4cc7974057500e6bbbfb6e053fd807a6ab14aa7a2d8def233db19810::dvn_assign_job::AssignJobParam, 0x9de6d60206bfbc7b6f4c898b7d7c12dc749973098a9c346bca9d0cfa365be0d3::fee_recipient::FeeRecipient>(arg1, 0x601523f0fbdb81de1cb79b24d001a8aa85b9a848c337d51ab815fb476630b86c::worker_common::worker_cap(&arg0.worker), false);
        let v1 = *0x51c7613a4cc7974057500e6bbbfb6e053fd807a6ab14aa7a2d8def233db19810::dvn_assign_job::base(0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call::param<0x51c7613a4cc7974057500e6bbbfb6e053fd807a6ab14aa7a2d8def233db19810::dvn_assign_job::AssignJobParam, 0x9de6d60206bfbc7b6f4c898b7d7c12dc749973098a9c346bca9d0cfa365be0d3::fee_recipient::FeeRecipient>(v0));
        create_feelib_get_fee_call<0x51c7613a4cc7974057500e6bbbfb6e053fd807a6ab14aa7a2d8def233db19810::dvn_assign_job::AssignJobParam, 0x9de6d60206bfbc7b6f4c898b7d7c12dc749973098a9c346bca9d0cfa365be0d3::fee_recipient::FeeRecipient>(arg0, v0, v1, arg2)
    }

    public fun confirm_assign_job(arg0: &DVN, arg1: &mut 0xf00ed2e3fedf4a517c5ab2a2a52d985a127381d49bb24c8428b1f757846c5cdd::multi_call::MultiCall<0x51c7613a4cc7974057500e6bbbfb6e053fd807a6ab14aa7a2d8def233db19810::dvn_assign_job::AssignJobParam, 0x9de6d60206bfbc7b6f4c898b7d7c12dc749973098a9c346bca9d0cfa365be0d3::fee_recipient::FeeRecipient>, arg2: 0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call::Call<0xdca981787d26a288b49d73b58aa8e7938022072b9ac6e8b843508ccfc0d8ac53::dvn_feelib_get_fee::FeelibGetFeeParam, u64>) {
        let v0 = 0xf00ed2e3fedf4a517c5ab2a2a52d985a127381d49bb24c8428b1f757846c5cdd::multi_call::borrow_next<0x51c7613a4cc7974057500e6bbbfb6e053fd807a6ab14aa7a2d8def233db19810::dvn_assign_job::AssignJobParam, 0x9de6d60206bfbc7b6f4c898b7d7c12dc749973098a9c346bca9d0cfa365be0d3::fee_recipient::FeeRecipient>(arg1, 0x601523f0fbdb81de1cb79b24d001a8aa85b9a848c337d51ab815fb476630b86c::worker_common::worker_cap(&arg0.worker), true);
        let (_, _, v3) = 0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call::destroy_child<0x51c7613a4cc7974057500e6bbbfb6e053fd807a6ab14aa7a2d8def233db19810::dvn_assign_job::AssignJobParam, 0x9de6d60206bfbc7b6f4c898b7d7c12dc749973098a9c346bca9d0cfa365be0d3::fee_recipient::FeeRecipient, 0xdca981787d26a288b49d73b58aa8e7938022072b9ac6e8b843508ccfc0d8ac53::dvn_feelib_get_fee::FeelibGetFeeParam, u64>(v0, 0x601523f0fbdb81de1cb79b24d001a8aa85b9a848c337d51ab815fb476630b86c::worker_common::worker_cap(&arg0.worker), arg2);
        0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call::complete<0x51c7613a4cc7974057500e6bbbfb6e053fd807a6ab14aa7a2d8def233db19810::dvn_assign_job::AssignJobParam, 0x9de6d60206bfbc7b6f4c898b7d7c12dc749973098a9c346bca9d0cfa365be0d3::fee_recipient::FeeRecipient>(v0, 0x601523f0fbdb81de1cb79b24d001a8aa85b9a848c337d51ab815fb476630b86c::worker_common::worker_cap(&arg0.worker), 0x9de6d60206bfbc7b6f4c898b7d7c12dc749973098a9c346bca9d0cfa365be0d3::fee_recipient::create(v3, 0x601523f0fbdb81de1cb79b24d001a8aa85b9a848c337d51ab815fb476630b86c::worker_common::deposit_address(&arg0.worker)));
    }

    public fun confirm_get_fee(arg0: &DVN, arg1: &mut 0xf00ed2e3fedf4a517c5ab2a2a52d985a127381d49bb24c8428b1f757846c5cdd::multi_call::MultiCall<0x51c7613a4cc7974057500e6bbbfb6e053fd807a6ab14aa7a2d8def233db19810::dvn_get_fee::GetFeeParam, u64>, arg2: 0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call::Call<0xdca981787d26a288b49d73b58aa8e7938022072b9ac6e8b843508ccfc0d8ac53::dvn_feelib_get_fee::FeelibGetFeeParam, u64>) {
        let v0 = 0xf00ed2e3fedf4a517c5ab2a2a52d985a127381d49bb24c8428b1f757846c5cdd::multi_call::borrow_next<0x51c7613a4cc7974057500e6bbbfb6e053fd807a6ab14aa7a2d8def233db19810::dvn_get_fee::GetFeeParam, u64>(arg1, 0x601523f0fbdb81de1cb79b24d001a8aa85b9a848c337d51ab815fb476630b86c::worker_common::worker_cap(&arg0.worker), true);
        let (_, _, v3) = 0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call::destroy_child<0x51c7613a4cc7974057500e6bbbfb6e053fd807a6ab14aa7a2d8def233db19810::dvn_get_fee::GetFeeParam, u64, 0xdca981787d26a288b49d73b58aa8e7938022072b9ac6e8b843508ccfc0d8ac53::dvn_feelib_get_fee::FeelibGetFeeParam, u64>(v0, 0x601523f0fbdb81de1cb79b24d001a8aa85b9a848c337d51ab815fb476630b86c::worker_common::worker_cap(&arg0.worker), arg2);
        0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call::complete<0x51c7613a4cc7974057500e6bbbfb6e053fd807a6ab14aa7a2d8def233db19810::dvn_get_fee::GetFeeParam, u64>(v0, 0x601523f0fbdb81de1cb79b24d001a8aa85b9a848c337d51ab815fb476630b86c::worker_common::worker_cap(&arg0.worker), v3);
    }

    public fun create_dvn(arg0: 0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call_cap::CallCap, arg1: u32, arg2: address, arg3: vector<address>, arg4: address, arg5: address, arg6: u16, arg7: vector<address>, arg8: vector<vector<u8>>, arg9: u64, arg10: &mut 0xb8d08d3a9604c51ec6ad8ee39a05e9c3fed1335df755089f1d3f0e093b9a4ec8::worker_registry::WorkerRegistry, arg11: &mut 0x2::tx_context::TxContext) : address {
        let (v0, v1) = 0x601523f0fbdb81de1cb79b24d001a8aa85b9a848c337d51ab815fb476630b86c::worker_common::create_worker(arg0, arg2, arg3, arg4, arg5, arg6, arg7, arg11);
        let v2 = DVN{
            id                      : 0x2::object::new(arg11),
            vid                     : arg1,
            worker                  : v0,
            dst_configs             : 0x2::table::new<u32, DstConfig>(arg11),
            multisig                : 0x60d4ef2e0e057d19e947406ccec3ac4d0208adc8e1981964ab2552166a30f461::multisig::new(arg8, arg9),
            used_hashes             : 0x2::table::new<0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::Bytes32, bool>(arg11),
            owner_cap               : v1,
            ptb_builder_initialized : false,
        };
        let v3 = 0x2::object::id_address<DVN>(&v2);
        let v4 = 0x60d4ef2e0e057d19e947406ccec3ac4d0208adc8e1981964ab2552166a30f461::dvn_info_v1::create(v3);
        let v5 = 0x601523f0fbdb81de1cb79b24d001a8aa85b9a848c337d51ab815fb476630b86c::worker_info_v1::create(2, 0x60d4ef2e0e057d19e947406ccec3ac4d0208adc8e1981964ab2552166a30f461::dvn_info_v1::encode(&v4));
        0xb8d08d3a9604c51ec6ad8ee39a05e9c3fed1335df755089f1d3f0e093b9a4ec8::worker_registry::set_worker_info(arg10, 0x601523f0fbdb81de1cb79b24d001a8aa85b9a848c337d51ab815fb476630b86c::worker_common::worker_cap(&v2.worker), 0x601523f0fbdb81de1cb79b24d001a8aa85b9a848c337d51ab815fb476630b86c::worker_info_v1::encode(&v5));
        0x2::transfer::share_object<DVN>(v2);
        v3
    }

    fun create_feelib_get_fee_call<T0, T1>(arg0: &DVN, arg1: &mut 0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call::Call<T0, T1>, arg2: 0x51c7613a4cc7974057500e6bbbfb6e053fd807a6ab14aa7a2d8def233db19810::dvn_get_fee::GetFeeParam, arg3: &mut 0x2::tx_context::TxContext) : 0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call::Call<0xdca981787d26a288b49d73b58aa8e7938022072b9ac6e8b843508ccfc0d8ac53::dvn_feelib_get_fee::FeelibGetFeeParam, u64> {
        0x601523f0fbdb81de1cb79b24d001a8aa85b9a848c337d51ab815fb476630b86c::worker_common::assert_supported_message_lib(&arg0.worker, 0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call::caller<T0, T1>(arg1));
        0x601523f0fbdb81de1cb79b24d001a8aa85b9a848c337d51ab815fb476630b86c::worker_common::assert_acl(&arg0.worker, 0x51c7613a4cc7974057500e6bbbfb6e053fd807a6ab14aa7a2d8def233db19810::dvn_get_fee::sender(&arg2));
        0x601523f0fbdb81de1cb79b24d001a8aa85b9a848c337d51ab815fb476630b86c::worker_common::assert_worker_unpaused(&arg0.worker);
        let v0 = dst_config(arg0, 0x51c7613a4cc7974057500e6bbbfb6e053fd807a6ab14aa7a2d8def233db19810::dvn_get_fee::dst_eid(&arg2));
        0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call::create_single_child<T0, T1, 0xdca981787d26a288b49d73b58aa8e7938022072b9ac6e8b843508ccfc0d8ac53::dvn_feelib_get_fee::FeelibGetFeeParam, u64>(arg1, 0x601523f0fbdb81de1cb79b24d001a8aa85b9a848c337d51ab815fb476630b86c::worker_common::worker_cap(&arg0.worker), 0x601523f0fbdb81de1cb79b24d001a8aa85b9a848c337d51ab815fb476630b86c::worker_common::worker_fee_lib(&arg0.worker), 0xdca981787d26a288b49d73b58aa8e7938022072b9ac6e8b843508ccfc0d8ac53::dvn_feelib_get_fee::create_param(0x51c7613a4cc7974057500e6bbbfb6e053fd807a6ab14aa7a2d8def233db19810::dvn_get_fee::sender(&arg2), 0x51c7613a4cc7974057500e6bbbfb6e053fd807a6ab14aa7a2d8def233db19810::dvn_get_fee::dst_eid(&arg2), 0x51c7613a4cc7974057500e6bbbfb6e053fd807a6ab14aa7a2d8def233db19810::dvn_get_fee::confirmations(&arg2), *0x51c7613a4cc7974057500e6bbbfb6e053fd807a6ab14aa7a2d8def233db19810::dvn_get_fee::options(&arg2), 0x60d4ef2e0e057d19e947406ccec3ac4d0208adc8e1981964ab2552166a30f461::multisig::quorum(&arg0.multisig), 0x601523f0fbdb81de1cb79b24d001a8aa85b9a848c337d51ab815fb476630b86c::worker_common::price_feed(&arg0.worker), 0x601523f0fbdb81de1cb79b24d001a8aa85b9a848c337d51ab815fb476630b86c::worker_common::default_multiplier_bps(&arg0.worker), v0.gas, v0.multiplier_bps, v0.floor_margin_usd), arg3)
    }

    public fun dst_config(arg0: &DVN, arg1: u32) : DstConfig {
        assert!(0x2::table::contains<u32, DstConfig>(&arg0.dst_configs, arg1), 2);
        *0x2::table::borrow<u32, DstConfig>(&arg0.dst_configs, arg1)
    }

    public fun get_fee(arg0: &DVN, arg1: &mut 0xf00ed2e3fedf4a517c5ab2a2a52d985a127381d49bb24c8428b1f757846c5cdd::multi_call::MultiCall<0x51c7613a4cc7974057500e6bbbfb6e053fd807a6ab14aa7a2d8def233db19810::dvn_get_fee::GetFeeParam, u64>, arg2: &mut 0x2::tx_context::TxContext) : 0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call::Call<0xdca981787d26a288b49d73b58aa8e7938022072b9ac6e8b843508ccfc0d8ac53::dvn_feelib_get_fee::FeelibGetFeeParam, u64> {
        let v0 = 0xf00ed2e3fedf4a517c5ab2a2a52d985a127381d49bb24c8428b1f757846c5cdd::multi_call::borrow_next<0x51c7613a4cc7974057500e6bbbfb6e053fd807a6ab14aa7a2d8def233db19810::dvn_get_fee::GetFeeParam, u64>(arg1, 0x601523f0fbdb81de1cb79b24d001a8aa85b9a848c337d51ab815fb476630b86c::worker_common::worker_cap(&arg0.worker), false);
        let v1 = *0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call::param<0x51c7613a4cc7974057500e6bbbfb6e053fd807a6ab14aa7a2d8def233db19810::dvn_get_fee::GetFeeParam, u64>(v0);
        create_feelib_get_fee_call<0x51c7613a4cc7974057500e6bbbfb6e053fd807a6ab14aa7a2d8def233db19810::dvn_get_fee::GetFeeParam, u64>(arg0, v0, v1, arg2)
    }

    public fun init_ptb_builder_move_calls(arg0: &mut DVN, arg1: &0x601523f0fbdb81de1cb79b24d001a8aa85b9a848c337d51ab815fb476630b86c::worker_common::AdminCap, arg2: address, arg3: vector<0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::move_call::MoveCall>, arg4: vector<0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::move_call::MoveCall>, arg5: &mut 0x2::tx_context::TxContext) : 0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call::Call<0xd412a95bfe4645ddb920e3c08cfb8f7cfe9c8fe9897e957ca161cc6b85987fc5::set_worker_ptb::SetWorkerPtbParam, 0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call::Void> {
        assert!(!arg0.ptb_builder_initialized, 4);
        set_ptb_builder_move_calls_internal(arg0, arg1, arg2, arg3, arg4, arg5)
    }

    public fun is_allowlisted(arg0: &DVN, arg1: address) : bool {
        0x601523f0fbdb81de1cb79b24d001a8aa85b9a848c337d51ab815fb476630b86c::worker_common::is_on_allowlist(&arg0.worker, arg1)
    }

    public fun is_denylisted(arg0: &DVN, arg1: address) : bool {
        0x601523f0fbdb81de1cb79b24d001a8aa85b9a848c337d51ab815fb476630b86c::worker_common::is_on_denylist(&arg0.worker, arg1)
    }

    public fun is_ptb_builder_initialized(arg0: &DVN) : bool {
        arg0.ptb_builder_initialized
    }

    public fun is_signer(arg0: &DVN, arg1: vector<u8>) : bool {
        0x60d4ef2e0e057d19e947406ccec3ac4d0208adc8e1981964ab2552166a30f461::multisig::is_signer(&arg0.multisig, arg1)
    }

    public fun quorum(arg0: &DVN) : u64 {
        0x60d4ef2e0e057d19e947406ccec3ac4d0208adc8e1981964ab2552166a30f461::multisig::quorum(&arg0.multisig)
    }

    public fun quorum_change_admin(arg0: &mut DVN, arg1: address, arg2: bool, arg3: u64, arg4: vector<u8>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x60d4ef2e0e057d19e947406ccec3ac4d0208adc8e1981964ab2552166a30f461::hashes::build_quorum_change_admin_payload(arg1, arg2, arg0.vid, arg3);
        assert_all_and_add_to_history(arg0, &arg4, arg3, v0, arg5);
        0x601523f0fbdb81de1cb79b24d001a8aa85b9a848c337d51ab815fb476630b86c::worker_common::set_admin(&mut arg0.worker, &arg0.owner_cap, arg1, arg2, arg6);
    }

    public fun set_dst_config(arg0: &mut DVN, arg1: &0x601523f0fbdb81de1cb79b24d001a8aa85b9a848c337d51ab815fb476630b86c::worker_common::AdminCap, arg2: u32, arg3: u256, arg4: u16, arg5: u128) {
        0x601523f0fbdb81de1cb79b24d001a8aa85b9a848c337d51ab815fb476630b86c::worker_common::assert_admin(&arg0.worker, arg1);
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
            dvn              : 0x601523f0fbdb81de1cb79b24d001a8aa85b9a848c337d51ab815fb476630b86c::worker_common::worker_cap_address(&arg0.worker),
            dst_eid          : arg2,
            gas              : arg3,
            multiplier_bps   : arg4,
            floor_margin_usd : arg5,
        };
        0x2::event::emit<SetDstConfigEvent>(v2);
    }

    public fun set_dvn_signer(arg0: &mut DVN, arg1: &0x601523f0fbdb81de1cb79b24d001a8aa85b9a848c337d51ab815fb476630b86c::worker_common::AdminCap, arg2: vector<u8>, arg3: bool, arg4: u64, arg5: vector<u8>, arg6: &0x2::clock::Clock) {
        0x601523f0fbdb81de1cb79b24d001a8aa85b9a848c337d51ab815fb476630b86c::worker_common::assert_admin(&arg0.worker, arg1);
        let v0 = 0x60d4ef2e0e057d19e947406ccec3ac4d0208adc8e1981964ab2552166a30f461::hashes::build_set_dvn_signer_payload(arg2, arg3, arg0.vid, arg4);
        assert_all_and_add_to_history(arg0, &arg5, arg4, v0, arg6);
        0x60d4ef2e0e057d19e947406ccec3ac4d0208adc8e1981964ab2552166a30f461::multisig::set_signer(&mut arg0.multisig, worker_cap_address(arg0), arg2, arg3);
    }

    public fun set_ptb_builder_move_calls(arg0: &mut DVN, arg1: &0x601523f0fbdb81de1cb79b24d001a8aa85b9a848c337d51ab815fb476630b86c::worker_common::AdminCap, arg2: address, arg3: vector<0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::move_call::MoveCall>, arg4: vector<0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::move_call::MoveCall>, arg5: u64, arg6: vector<u8>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : 0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call::Call<0xd412a95bfe4645ddb920e3c08cfb8f7cfe9c8fe9897e957ca161cc6b85987fc5::set_worker_ptb::SetWorkerPtbParam, 0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call::Void> {
        let v0 = 0x60d4ef2e0e057d19e947406ccec3ac4d0208adc8e1981964ab2552166a30f461::hashes::build_set_ptb_builder_move_calls_payload(arg2, arg3, arg4, arg0.vid, arg5);
        assert_all_and_add_to_history(arg0, &arg6, arg5, v0, arg7);
        set_ptb_builder_move_calls_internal(arg0, arg1, arg2, arg3, arg4, arg8)
    }

    fun set_ptb_builder_move_calls_internal(arg0: &mut DVN, arg1: &0x601523f0fbdb81de1cb79b24d001a8aa85b9a848c337d51ab815fb476630b86c::worker_common::AdminCap, arg2: address, arg3: vector<0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::move_call::MoveCall>, arg4: vector<0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::move_call::MoveCall>, arg5: &mut 0x2::tx_context::TxContext) : 0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call::Call<0xd412a95bfe4645ddb920e3c08cfb8f7cfe9c8fe9897e957ca161cc6b85987fc5::set_worker_ptb::SetWorkerPtbParam, 0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call::Void> {
        0x601523f0fbdb81de1cb79b24d001a8aa85b9a848c337d51ab815fb476630b86c::worker_common::assert_admin(&arg0.worker, arg1);
        arg0.ptb_builder_initialized = true;
        0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call::create<0xd412a95bfe4645ddb920e3c08cfb8f7cfe9c8fe9897e957ca161cc6b85987fc5::set_worker_ptb::SetWorkerPtbParam, 0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call::Void>(0x601523f0fbdb81de1cb79b24d001a8aa85b9a848c337d51ab815fb476630b86c::worker_common::worker_cap(&arg0.worker), arg2, true, 0xd412a95bfe4645ddb920e3c08cfb8f7cfe9c8fe9897e957ca161cc6b85987fc5::set_worker_ptb::create_param(arg3, arg4), arg5)
    }

    public fun set_quorum(arg0: &mut DVN, arg1: &0x601523f0fbdb81de1cb79b24d001a8aa85b9a848c337d51ab815fb476630b86c::worker_common::AdminCap, arg2: u64, arg3: u64, arg4: vector<u8>, arg5: &0x2::clock::Clock) {
        0x601523f0fbdb81de1cb79b24d001a8aa85b9a848c337d51ab815fb476630b86c::worker_common::assert_admin(&arg0.worker, arg1);
        let v0 = 0x60d4ef2e0e057d19e947406ccec3ac4d0208adc8e1981964ab2552166a30f461::hashes::build_set_quorum_payload(arg2, arg0.vid, arg3);
        assert_all_and_add_to_history(arg0, &arg4, arg3, v0, arg5);
        0x60d4ef2e0e057d19e947406ccec3ac4d0208adc8e1981964ab2552166a30f461::multisig::set_quorum(&mut arg0.multisig, worker_cap_address(arg0), arg2);
    }

    public fun set_worker_info(arg0: &mut DVN, arg1: &0x601523f0fbdb81de1cb79b24d001a8aa85b9a848c337d51ab815fb476630b86c::worker_common::AdminCap, arg2: &mut 0xb8d08d3a9604c51ec6ad8ee39a05e9c3fed1335df755089f1d3f0e093b9a4ec8::worker_registry::WorkerRegistry, arg3: vector<u8>, arg4: u64, arg5: vector<u8>, arg6: &0x2::clock::Clock) {
        0x601523f0fbdb81de1cb79b24d001a8aa85b9a848c337d51ab815fb476630b86c::worker_common::assert_admin(&arg0.worker, arg1);
        let v0 = 0x60d4ef2e0e057d19e947406ccec3ac4d0208adc8e1981964ab2552166a30f461::hashes::build_set_worker_info_payload(arg3, arg0.vid, arg4);
        assert_all_and_add_to_history(arg0, &arg5, arg4, v0, arg6);
        0xb8d08d3a9604c51ec6ad8ee39a05e9c3fed1335df755089f1d3f0e093b9a4ec8::worker_registry::set_worker_info(arg2, 0x601523f0fbdb81de1cb79b24d001a8aa85b9a848c337d51ab815fb476630b86c::worker_common::worker_cap(&arg0.worker), arg3);
    }

    public fun signer_count(arg0: &DVN) : u64 {
        0x60d4ef2e0e057d19e947406ccec3ac4d0208adc8e1981964ab2552166a30f461::multisig::signer_count(&arg0.multisig)
    }

    public fun signers(arg0: &DVN) : vector<vector<u8>> {
        0x60d4ef2e0e057d19e947406ccec3ac4d0208adc8e1981964ab2552166a30f461::multisig::get_signers(&arg0.multisig)
    }

    public fun supported_option_types(arg0: &DVN, arg1: u32) : vector<u8> {
        0x601523f0fbdb81de1cb79b24d001a8aa85b9a848c337d51ab815fb476630b86c::worker_common::get_supported_option_types(&arg0.worker, arg1)
    }

    public fun verify(arg0: &mut DVN, arg1: &0x601523f0fbdb81de1cb79b24d001a8aa85b9a848c337d51ab815fb476630b86c::worker_common::AdminCap, arg2: address, arg3: vector<u8>, arg4: 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::Bytes32, arg5: u64, arg6: u64, arg7: vector<u8>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : 0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call::Call<0x51c7613a4cc7974057500e6bbbfb6e053fd807a6ab14aa7a2d8def233db19810::dvn_verify::VerifyParam, 0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call::Void> {
        0x601523f0fbdb81de1cb79b24d001a8aa85b9a848c337d51ab815fb476630b86c::worker_common::assert_admin(&arg0.worker, arg1);
        let v0 = 0x60d4ef2e0e057d19e947406ccec3ac4d0208adc8e1981964ab2552166a30f461::hashes::build_verify_payload(arg3, 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::to_bytes(&arg4), arg5, arg2, arg0.vid, arg6);
        assert_all_and_add_to_history(arg0, &arg7, arg6, v0, arg8);
        0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call::create<0x51c7613a4cc7974057500e6bbbfb6e053fd807a6ab14aa7a2d8def233db19810::dvn_verify::VerifyParam, 0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call::Void>(0x601523f0fbdb81de1cb79b24d001a8aa85b9a848c337d51ab815fb476630b86c::worker_common::worker_cap(&arg0.worker), arg2, true, 0x51c7613a4cc7974057500e6bbbfb6e053fd807a6ab14aa7a2d8def233db19810::dvn_verify::create_param(arg3, arg4, arg5), arg9)
    }

    public fun vid(arg0: &DVN) : u32 {
        arg0.vid
    }

    // decompiled from Move bytecode v6
}

