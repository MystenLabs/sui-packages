module 0x11da80425fb389d1090743a2a33a48c479f4fd218a25db2cdc072b768a47ce5::executor_worker {
    struct Executor has key {
        id: 0x2::object::UID,
        worker: 0x601523f0fbdb81de1cb79b24d001a8aa85b9a848c337d51ab815fb476630b86c::worker_common::Worker,
        dst_configs: 0x2::table::Table<u32, 0x11da80425fb389d1090743a2a33a48c479f4fd218a25db2cdc072b768a47ce5::executor_type::DstConfig>,
    }

    struct DstConfigSetEvent has copy, drop {
        executor: address,
        dst_eid: u32,
        config: 0x11da80425fb389d1090743a2a33a48c479f4fd218a25db2cdc072b768a47ce5::executor_type::DstConfig,
    }

    struct NativeDropAppliedEvent has copy, drop {
        executor: address,
        src_eid: u32,
        sender: 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::Bytes32,
        dst_eid: u32,
        oapp: address,
        nonce: u64,
        params: vector<0x11da80425fb389d1090743a2a33a48c479f4fd218a25db2cdc072b768a47ce5::native_drop_type::NativeDropParams>,
        success: vector<bool>,
    }

    public fun admin_cap_id(arg0: &Executor, arg1: address) : address {
        0x601523f0fbdb81de1cb79b24d001a8aa85b9a848c337d51ab815fb476630b86c::worker_common::get_admin_cap_id(&arg0.worker, arg1)
    }

    public fun admins(arg0: &Executor) : 0x2::vec_set::VecSet<address> {
        0x601523f0fbdb81de1cb79b24d001a8aa85b9a848c337d51ab815fb476630b86c::worker_common::admins(&arg0.worker)
    }

    public fun allowlist_size(arg0: &Executor) : u64 {
        0x601523f0fbdb81de1cb79b24d001a8aa85b9a848c337d51ab815fb476630b86c::worker_common::allowlist_size(&arg0.worker)
    }

    public fun assign_job(arg0: &Executor, arg1: &mut 0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call::Call<0x51c7613a4cc7974057500e6bbbfb6e053fd807a6ab14aa7a2d8def233db19810::executor_assign_job::AssignJobParam, 0x9de6d60206bfbc7b6f4c898b7d7c12dc749973098a9c346bca9d0cfa365be0d3::fee_recipient::FeeRecipient>, arg2: &mut 0x2::tx_context::TxContext) : 0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call::Call<0xe0bee4ca2391b73abc182744d5a4cda66fd5822150ea652de6da4ddf691b5e3a::executor_feelib_get_fee::FeelibGetFeeParam, u64> {
        let v0 = *0x51c7613a4cc7974057500e6bbbfb6e053fd807a6ab14aa7a2d8def233db19810::executor_assign_job::base(0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call::param<0x51c7613a4cc7974057500e6bbbfb6e053fd807a6ab14aa7a2d8def233db19810::executor_assign_job::AssignJobParam, 0x9de6d60206bfbc7b6f4c898b7d7c12dc749973098a9c346bca9d0cfa365be0d3::fee_recipient::FeeRecipient>(arg1));
        create_feelib_get_fee_call<0x51c7613a4cc7974057500e6bbbfb6e053fd807a6ab14aa7a2d8def233db19810::executor_assign_job::AssignJobParam, 0x9de6d60206bfbc7b6f4c898b7d7c12dc749973098a9c346bca9d0cfa365be0d3::fee_recipient::FeeRecipient>(arg0, arg1, v0, arg2)
    }

    public fun confirm_assign_job(arg0: &Executor, arg1: &mut 0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call::Call<0x51c7613a4cc7974057500e6bbbfb6e053fd807a6ab14aa7a2d8def233db19810::executor_assign_job::AssignJobParam, 0x9de6d60206bfbc7b6f4c898b7d7c12dc749973098a9c346bca9d0cfa365be0d3::fee_recipient::FeeRecipient>, arg2: 0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call::Call<0xe0bee4ca2391b73abc182744d5a4cda66fd5822150ea652de6da4ddf691b5e3a::executor_feelib_get_fee::FeelibGetFeeParam, u64>) {
        let (_, _, v2) = 0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call::destroy_child<0x51c7613a4cc7974057500e6bbbfb6e053fd807a6ab14aa7a2d8def233db19810::executor_assign_job::AssignJobParam, 0x9de6d60206bfbc7b6f4c898b7d7c12dc749973098a9c346bca9d0cfa365be0d3::fee_recipient::FeeRecipient, 0xe0bee4ca2391b73abc182744d5a4cda66fd5822150ea652de6da4ddf691b5e3a::executor_feelib_get_fee::FeelibGetFeeParam, u64>(arg1, 0x601523f0fbdb81de1cb79b24d001a8aa85b9a848c337d51ab815fb476630b86c::worker_common::worker_cap(&arg0.worker), arg2);
        0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call::complete<0x51c7613a4cc7974057500e6bbbfb6e053fd807a6ab14aa7a2d8def233db19810::executor_assign_job::AssignJobParam, 0x9de6d60206bfbc7b6f4c898b7d7c12dc749973098a9c346bca9d0cfa365be0d3::fee_recipient::FeeRecipient>(arg1, 0x601523f0fbdb81de1cb79b24d001a8aa85b9a848c337d51ab815fb476630b86c::worker_common::worker_cap(&arg0.worker), 0x9de6d60206bfbc7b6f4c898b7d7c12dc749973098a9c346bca9d0cfa365be0d3::fee_recipient::create(v2, 0x601523f0fbdb81de1cb79b24d001a8aa85b9a848c337d51ab815fb476630b86c::worker_common::deposit_address(&arg0.worker)));
    }

    public fun confirm_get_fee(arg0: &Executor, arg1: &mut 0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call::Call<0x51c7613a4cc7974057500e6bbbfb6e053fd807a6ab14aa7a2d8def233db19810::executor_get_fee::GetFeeParam, u64>, arg2: 0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call::Call<0xe0bee4ca2391b73abc182744d5a4cda66fd5822150ea652de6da4ddf691b5e3a::executor_feelib_get_fee::FeelibGetFeeParam, u64>) {
        let (_, _, v2) = 0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call::destroy_child<0x51c7613a4cc7974057500e6bbbfb6e053fd807a6ab14aa7a2d8def233db19810::executor_get_fee::GetFeeParam, u64, 0xe0bee4ca2391b73abc182744d5a4cda66fd5822150ea652de6da4ddf691b5e3a::executor_feelib_get_fee::FeelibGetFeeParam, u64>(arg1, 0x601523f0fbdb81de1cb79b24d001a8aa85b9a848c337d51ab815fb476630b86c::worker_common::worker_cap(&arg0.worker), arg2);
        0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call::complete<0x51c7613a4cc7974057500e6bbbfb6e053fd807a6ab14aa7a2d8def233db19810::executor_get_fee::GetFeeParam, u64>(arg1, 0x601523f0fbdb81de1cb79b24d001a8aa85b9a848c337d51ab815fb476630b86c::worker_common::worker_cap(&arg0.worker), v2);
    }

    public fun create_executor(arg0: 0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call_cap::CallCap, arg1: address, arg2: vector<address>, arg3: address, arg4: address, arg5: u16, arg6: address, arg7: vector<address>, arg8: &mut 0xb8d08d3a9604c51ec6ad8ee39a05e9c3fed1335df755089f1d3f0e093b9a4ec8::worker_registry::WorkerRegistry, arg9: &mut 0x2::tx_context::TxContext) : address {
        let (v0, v1) = 0x601523f0fbdb81de1cb79b24d001a8aa85b9a848c337d51ab815fb476630b86c::worker_common::create_worker(arg0, arg1, arg2, arg3, arg4, arg5, arg7, arg9);
        let v2 = Executor{
            id          : 0x2::object::new(arg9),
            worker      : v0,
            dst_configs : 0x2::table::new<u32, 0x11da80425fb389d1090743a2a33a48c479f4fd218a25db2cdc072b768a47ce5::executor_type::DstConfig>(arg9),
        };
        0x2::transfer::public_transfer<0x601523f0fbdb81de1cb79b24d001a8aa85b9a848c337d51ab815fb476630b86c::worker_common::OwnerCap>(v1, arg6);
        let v3 = 0x2::object::id_address<Executor>(&v2);
        let v4 = 0x11da80425fb389d1090743a2a33a48c479f4fd218a25db2cdc072b768a47ce5::executor_info_v1::create(v3);
        let v5 = 0x601523f0fbdb81de1cb79b24d001a8aa85b9a848c337d51ab815fb476630b86c::worker_info_v1::create(1, 0x11da80425fb389d1090743a2a33a48c479f4fd218a25db2cdc072b768a47ce5::executor_info_v1::encode(&v4));
        0xb8d08d3a9604c51ec6ad8ee39a05e9c3fed1335df755089f1d3f0e093b9a4ec8::worker_registry::set_worker_info(arg8, 0x601523f0fbdb81de1cb79b24d001a8aa85b9a848c337d51ab815fb476630b86c::worker_common::worker_cap(&v2.worker), 0x601523f0fbdb81de1cb79b24d001a8aa85b9a848c337d51ab815fb476630b86c::worker_info_v1::encode(&v5));
        0x2::transfer::share_object<Executor>(v2);
        v3
    }

    fun create_feelib_get_fee_call<T0, T1>(arg0: &Executor, arg1: &mut 0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call::Call<T0, T1>, arg2: 0x51c7613a4cc7974057500e6bbbfb6e053fd807a6ab14aa7a2d8def233db19810::executor_get_fee::GetFeeParam, arg3: &mut 0x2::tx_context::TxContext) : 0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call::Call<0xe0bee4ca2391b73abc182744d5a4cda66fd5822150ea652de6da4ddf691b5e3a::executor_feelib_get_fee::FeelibGetFeeParam, u64> {
        0x601523f0fbdb81de1cb79b24d001a8aa85b9a848c337d51ab815fb476630b86c::worker_common::assert_supported_message_lib(&arg0.worker, 0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call::caller<T0, T1>(arg1));
        0x601523f0fbdb81de1cb79b24d001a8aa85b9a848c337d51ab815fb476630b86c::worker_common::assert_acl(&arg0.worker, 0x51c7613a4cc7974057500e6bbbfb6e053fd807a6ab14aa7a2d8def233db19810::executor_get_fee::sender(&arg2));
        0x601523f0fbdb81de1cb79b24d001a8aa85b9a848c337d51ab815fb476630b86c::worker_common::assert_worker_unpaused(&arg0.worker);
        let v0 = dst_config(arg0, 0x51c7613a4cc7974057500e6bbbfb6e053fd807a6ab14aa7a2d8def233db19810::executor_get_fee::dst_eid(&arg2));
        0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call::create_single_child<T0, T1, 0xe0bee4ca2391b73abc182744d5a4cda66fd5822150ea652de6da4ddf691b5e3a::executor_feelib_get_fee::FeelibGetFeeParam, u64>(arg1, 0x601523f0fbdb81de1cb79b24d001a8aa85b9a848c337d51ab815fb476630b86c::worker_common::worker_cap(&arg0.worker), 0x601523f0fbdb81de1cb79b24d001a8aa85b9a848c337d51ab815fb476630b86c::worker_common::worker_fee_lib(&arg0.worker), 0xe0bee4ca2391b73abc182744d5a4cda66fd5822150ea652de6da4ddf691b5e3a::executor_feelib_get_fee::create_param(0x51c7613a4cc7974057500e6bbbfb6e053fd807a6ab14aa7a2d8def233db19810::executor_get_fee::sender(&arg2), 0x51c7613a4cc7974057500e6bbbfb6e053fd807a6ab14aa7a2d8def233db19810::executor_get_fee::dst_eid(&arg2), 0x51c7613a4cc7974057500e6bbbfb6e053fd807a6ab14aa7a2d8def233db19810::executor_get_fee::calldata_size(&arg2), *0x51c7613a4cc7974057500e6bbbfb6e053fd807a6ab14aa7a2d8def233db19810::executor_get_fee::options(&arg2), 0x601523f0fbdb81de1cb79b24d001a8aa85b9a848c337d51ab815fb476630b86c::worker_common::price_feed(&arg0.worker), 0x601523f0fbdb81de1cb79b24d001a8aa85b9a848c337d51ab815fb476630b86c::worker_common::default_multiplier_bps(&arg0.worker), 0x11da80425fb389d1090743a2a33a48c479f4fd218a25db2cdc072b768a47ce5::executor_type::dst_config_lz_receive_base_gas(v0), 0x11da80425fb389d1090743a2a33a48c479f4fd218a25db2cdc072b768a47ce5::executor_type::dst_config_lz_compose_base_gas(v0), 0x11da80425fb389d1090743a2a33a48c479f4fd218a25db2cdc072b768a47ce5::executor_type::dst_config_floor_margin_usd(v0), 0x11da80425fb389d1090743a2a33a48c479f4fd218a25db2cdc072b768a47ce5::executor_type::dst_config_native_cap(v0), 0x11da80425fb389d1090743a2a33a48c479f4fd218a25db2cdc072b768a47ce5::executor_type::dst_config_multiplier_bps(v0)), arg3)
    }

    public fun default_multiplier_bps(arg0: &Executor) : u16 {
        0x601523f0fbdb81de1cb79b24d001a8aa85b9a848c337d51ab815fb476630b86c::worker_common::default_multiplier_bps(&arg0.worker)
    }

    public fun deposit_address(arg0: &Executor) : address {
        0x601523f0fbdb81de1cb79b24d001a8aa85b9a848c337d51ab815fb476630b86c::worker_common::deposit_address(&arg0.worker)
    }

    public fun dst_config(arg0: &Executor, arg1: u32) : &0x11da80425fb389d1090743a2a33a48c479f4fd218a25db2cdc072b768a47ce5::executor_type::DstConfig {
        let v0 = &arg0.dst_configs;
        assert!(0x2::table::contains<u32, 0x11da80425fb389d1090743a2a33a48c479f4fd218a25db2cdc072b768a47ce5::executor_type::DstConfig>(v0, arg1), 1);
        0x2::table::borrow<u32, 0x11da80425fb389d1090743a2a33a48c479f4fd218a25db2cdc072b768a47ce5::executor_type::DstConfig>(v0, arg1)
    }

    public fun execute_lz_compose(arg0: &Executor, arg1: &0x601523f0fbdb81de1cb79b24d001a8aa85b9a848c337d51ab815fb476630b86c::worker_common::AdminCap, arg2: &0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::endpoint_v2::EndpointV2, arg3: &mut 0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::messaging_composer::ComposeQueue, arg4: address, arg5: 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::Bytes32, arg6: u16, arg7: vector<u8>, arg8: vector<u8>, arg9: 0x1::option::Option<0x2::coin::Coin<0x2::sui::SUI>>, arg10: &mut 0x2::tx_context::TxContext) : 0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call::Call<0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::lz_compose::LzComposeParam, 0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call::Void> {
        0x601523f0fbdb81de1cb79b24d001a8aa85b9a848c337d51ab815fb476630b86c::worker_common::assert_admin(&arg0.worker, arg1);
        0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::endpoint_v2::lz_compose(arg2, 0x601523f0fbdb81de1cb79b24d001a8aa85b9a848c337d51ab815fb476630b86c::worker_common::worker_cap(&arg0.worker), arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10)
    }

    public fun execute_lz_receive(arg0: &Executor, arg1: &0x601523f0fbdb81de1cb79b24d001a8aa85b9a848c337d51ab815fb476630b86c::worker_common::AdminCap, arg2: &0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::endpoint_v2::EndpointV2, arg3: &mut 0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::messaging_channel::MessagingChannel, arg4: u32, arg5: 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::Bytes32, arg6: u64, arg7: 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::Bytes32, arg8: vector<u8>, arg9: vector<u8>, arg10: 0x1::option::Option<0x2::coin::Coin<0x2::sui::SUI>>, arg11: &mut 0x2::tx_context::TxContext) : 0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call::Call<0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::lz_receive::LzReceiveParam, 0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call::Void> {
        0x601523f0fbdb81de1cb79b24d001a8aa85b9a848c337d51ab815fb476630b86c::worker_common::assert_admin(&arg0.worker, arg1);
        0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::endpoint_v2::lz_receive(arg2, 0x601523f0fbdb81de1cb79b24d001a8aa85b9a848c337d51ab815fb476630b86c::worker_common::worker_cap(&arg0.worker), arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11)
    }

    public fun get_fee(arg0: &Executor, arg1: &mut 0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call::Call<0x51c7613a4cc7974057500e6bbbfb6e053fd807a6ab14aa7a2d8def233db19810::executor_get_fee::GetFeeParam, u64>, arg2: &mut 0x2::tx_context::TxContext) : 0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call::Call<0xe0bee4ca2391b73abc182744d5a4cda66fd5822150ea652de6da4ddf691b5e3a::executor_feelib_get_fee::FeelibGetFeeParam, u64> {
        let v0 = *0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call::param<0x51c7613a4cc7974057500e6bbbfb6e053fd807a6ab14aa7a2d8def233db19810::executor_get_fee::GetFeeParam, u64>(arg1);
        create_feelib_get_fee_call<0x51c7613a4cc7974057500e6bbbfb6e053fd807a6ab14aa7a2d8def233db19810::executor_get_fee::GetFeeParam, u64>(arg0, arg1, v0, arg2)
    }

    public fun has_acl(arg0: &Executor, arg1: address) : bool {
        0x601523f0fbdb81de1cb79b24d001a8aa85b9a848c337d51ab815fb476630b86c::worker_common::has_acl(&arg0.worker, arg1)
    }

    public fun is_admin(arg0: &Executor, arg1: &0x601523f0fbdb81de1cb79b24d001a8aa85b9a848c337d51ab815fb476630b86c::worker_common::AdminCap) : bool {
        0x601523f0fbdb81de1cb79b24d001a8aa85b9a848c337d51ab815fb476630b86c::worker_common::is_admin(&arg0.worker, arg1)
    }

    public fun is_admin_address(arg0: &Executor, arg1: address) : bool {
        0x601523f0fbdb81de1cb79b24d001a8aa85b9a848c337d51ab815fb476630b86c::worker_common::is_admin_address(&arg0.worker, arg1)
    }

    public fun is_allowlisted(arg0: &Executor, arg1: address) : bool {
        0x601523f0fbdb81de1cb79b24d001a8aa85b9a848c337d51ab815fb476630b86c::worker_common::is_on_allowlist(&arg0.worker, arg1)
    }

    public fun is_denylisted(arg0: &Executor, arg1: address) : bool {
        0x601523f0fbdb81de1cb79b24d001a8aa85b9a848c337d51ab815fb476630b86c::worker_common::is_on_denylist(&arg0.worker, arg1)
    }

    public fun is_paused(arg0: &Executor) : bool {
        0x601523f0fbdb81de1cb79b24d001a8aa85b9a848c337d51ab815fb476630b86c::worker_common::is_paused(&arg0.worker)
    }

    public fun is_supported_message_lib(arg0: &Executor, arg1: address) : bool {
        0x601523f0fbdb81de1cb79b24d001a8aa85b9a848c337d51ab815fb476630b86c::worker_common::is_supported_message_lib(&arg0.worker, arg1)
    }

    public fun lz_compose_alert(arg0: &Executor, arg1: &0x601523f0fbdb81de1cb79b24d001a8aa85b9a848c337d51ab815fb476630b86c::worker_common::AdminCap, arg2: address, arg3: address, arg4: 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::Bytes32, arg5: u16, arg6: u64, arg7: u64, arg8: vector<u8>, arg9: vector<u8>, arg10: 0x1::ascii::String) {
        0x601523f0fbdb81de1cb79b24d001a8aa85b9a848c337d51ab815fb476630b86c::worker_common::assert_admin(&arg0.worker, arg1);
        0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::endpoint_v2::lz_compose_alert(0x601523f0fbdb81de1cb79b24d001a8aa85b9a848c337d51ab815fb476630b86c::worker_common::worker_cap(&arg0.worker), arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10);
    }

    public fun lz_receive_alert(arg0: &Executor, arg1: &0x601523f0fbdb81de1cb79b24d001a8aa85b9a848c337d51ab815fb476630b86c::worker_common::AdminCap, arg2: u32, arg3: 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::Bytes32, arg4: u64, arg5: address, arg6: 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::Bytes32, arg7: u64, arg8: u64, arg9: vector<u8>, arg10: vector<u8>, arg11: 0x1::ascii::String) {
        0x601523f0fbdb81de1cb79b24d001a8aa85b9a848c337d51ab815fb476630b86c::worker_common::assert_admin(&arg0.worker, arg1);
        0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::endpoint_v2::lz_receive_alert(0x601523f0fbdb81de1cb79b24d001a8aa85b9a848c337d51ab815fb476630b86c::worker_common::worker_cap(&arg0.worker), arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11);
    }

    public fun native_drop(arg0: &Executor, arg1: &0x601523f0fbdb81de1cb79b24d001a8aa85b9a848c337d51ab815fb476630b86c::worker_common::AdminCap, arg2: u32, arg3: 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::Bytes32, arg4: u32, arg5: address, arg6: u64, arg7: vector<0x11da80425fb389d1090743a2a33a48c479f4fd218a25db2cdc072b768a47ce5::native_drop_type::NativeDropParams>, arg8: 0x2::coin::Coin<0x2::sui::SUI>, arg9: &mut 0x2::tx_context::TxContext) {
        0x601523f0fbdb81de1cb79b24d001a8aa85b9a848c337d51ab815fb476630b86c::worker_common::assert_admin(&arg0.worker, arg1);
        let v0 = &mut arg8;
        native_drop_internal(arg0, arg2, arg3, arg4, arg5, arg6, arg7, v0, arg9);
        0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::utils::transfer_coin<0x2::sui::SUI>(arg8, 0x2::tx_context::sender(arg9));
    }

    fun native_drop_internal(arg0: &Executor, arg1: u32, arg2: 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::Bytes32, arg3: u32, arg4: address, arg5: u64, arg6: vector<0x11da80425fb389d1090743a2a33a48c479f4fd218a25db2cdc072b768a47ce5::native_drop_type::NativeDropParams>, arg7: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = vector[];
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x11da80425fb389d1090743a2a33a48c479f4fd218a25db2cdc072b768a47ce5::native_drop_type::NativeDropParams>(&arg6)) {
            let v2 = 0x1::vector::borrow<0x11da80425fb389d1090743a2a33a48c479f4fd218a25db2cdc072b768a47ce5::native_drop_type::NativeDropParams>(&arg6, v1);
            let v3 = 0x11da80425fb389d1090743a2a33a48c479f4fd218a25db2cdc072b768a47ce5::native_drop_type::native_drop_params_amount(v2);
            assert!(v3 > 0, 2);
            let v4 = if (0x2::coin::value<0x2::sui::SUI>(arg7) >= v3) {
                0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(arg7, v3, arg8), 0x11da80425fb389d1090743a2a33a48c479f4fd218a25db2cdc072b768a47ce5::native_drop_type::native_drop_params_receiver(v2));
                true
            } else {
                false
            };
            0x1::vector::push_back<bool>(&mut v0, v4);
            v1 = v1 + 1;
        };
        let v5 = NativeDropAppliedEvent{
            executor : worker_cap_address(arg0),
            src_eid  : arg1,
            sender   : arg2,
            dst_eid  : arg3,
            oapp     : arg4,
            nonce    : arg5,
            params   : arg6,
            success  : v0,
        };
        0x2::event::emit<NativeDropAppliedEvent>(v5);
    }

    public fun price_feed(arg0: &Executor) : address {
        0x601523f0fbdb81de1cb79b24d001a8aa85b9a848c337d51ab815fb476630b86c::worker_common::price_feed(&arg0.worker)
    }

    public fun set_admin(arg0: &mut Executor, arg1: &0x601523f0fbdb81de1cb79b24d001a8aa85b9a848c337d51ab815fb476630b86c::worker_common::OwnerCap, arg2: address, arg3: bool, arg4: &mut 0x2::tx_context::TxContext) {
        0x601523f0fbdb81de1cb79b24d001a8aa85b9a848c337d51ab815fb476630b86c::worker_common::set_admin(&mut arg0.worker, arg1, arg2, arg3, arg4);
    }

    public fun set_allowlist(arg0: &mut Executor, arg1: &0x601523f0fbdb81de1cb79b24d001a8aa85b9a848c337d51ab815fb476630b86c::worker_common::OwnerCap, arg2: address, arg3: bool) {
        0x601523f0fbdb81de1cb79b24d001a8aa85b9a848c337d51ab815fb476630b86c::worker_common::set_allowlist(&mut arg0.worker, arg1, arg2, arg3);
    }

    public fun set_default_multiplier_bps(arg0: &mut Executor, arg1: &0x601523f0fbdb81de1cb79b24d001a8aa85b9a848c337d51ab815fb476630b86c::worker_common::AdminCap, arg2: u16) {
        0x601523f0fbdb81de1cb79b24d001a8aa85b9a848c337d51ab815fb476630b86c::worker_common::set_default_multiplier_bps(&mut arg0.worker, arg1, arg2);
    }

    public fun set_denylist(arg0: &mut Executor, arg1: &0x601523f0fbdb81de1cb79b24d001a8aa85b9a848c337d51ab815fb476630b86c::worker_common::OwnerCap, arg2: address, arg3: bool) {
        0x601523f0fbdb81de1cb79b24d001a8aa85b9a848c337d51ab815fb476630b86c::worker_common::set_denylist(&mut arg0.worker, arg1, arg2, arg3);
    }

    public fun set_deposit_address(arg0: &mut Executor, arg1: &0x601523f0fbdb81de1cb79b24d001a8aa85b9a848c337d51ab815fb476630b86c::worker_common::AdminCap, arg2: address) {
        0x601523f0fbdb81de1cb79b24d001a8aa85b9a848c337d51ab815fb476630b86c::worker_common::set_deposit_address(&mut arg0.worker, arg1, arg2);
    }

    public fun set_dst_config(arg0: &mut Executor, arg1: &0x601523f0fbdb81de1cb79b24d001a8aa85b9a848c337d51ab815fb476630b86c::worker_common::AdminCap, arg2: u32, arg3: 0x11da80425fb389d1090743a2a33a48c479f4fd218a25db2cdc072b768a47ce5::executor_type::DstConfig) {
        0x601523f0fbdb81de1cb79b24d001a8aa85b9a848c337d51ab815fb476630b86c::worker_common::assert_admin(&arg0.worker, arg1);
        let v0 = &mut arg0.dst_configs;
        if (0x2::table::contains<u32, 0x11da80425fb389d1090743a2a33a48c479f4fd218a25db2cdc072b768a47ce5::executor_type::DstConfig>(v0, arg2)) {
            *0x2::table::borrow_mut<u32, 0x11da80425fb389d1090743a2a33a48c479f4fd218a25db2cdc072b768a47ce5::executor_type::DstConfig>(v0, arg2) = arg3;
        } else {
            0x2::table::add<u32, 0x11da80425fb389d1090743a2a33a48c479f4fd218a25db2cdc072b768a47ce5::executor_type::DstConfig>(v0, arg2, arg3);
        };
        let v1 = DstConfigSetEvent{
            executor : worker_cap_address(arg0),
            dst_eid  : arg2,
            config   : arg3,
        };
        0x2::event::emit<DstConfigSetEvent>(v1);
    }

    public fun set_paused(arg0: &mut Executor, arg1: &0x601523f0fbdb81de1cb79b24d001a8aa85b9a848c337d51ab815fb476630b86c::worker_common::OwnerCap, arg2: bool) {
        0x601523f0fbdb81de1cb79b24d001a8aa85b9a848c337d51ab815fb476630b86c::worker_common::set_paused(&mut arg0.worker, arg1, arg2);
    }

    public fun set_price_feed(arg0: &mut Executor, arg1: &0x601523f0fbdb81de1cb79b24d001a8aa85b9a848c337d51ab815fb476630b86c::worker_common::AdminCap, arg2: address) {
        0x601523f0fbdb81de1cb79b24d001a8aa85b9a848c337d51ab815fb476630b86c::worker_common::set_price_feed(&mut arg0.worker, arg1, arg2);
    }

    public fun set_ptb_builder_move_calls(arg0: &mut Executor, arg1: &0x601523f0fbdb81de1cb79b24d001a8aa85b9a848c337d51ab815fb476630b86c::worker_common::OwnerCap, arg2: address, arg3: vector<0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::move_call::MoveCall>, arg4: vector<0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::move_call::MoveCall>, arg5: &mut 0x2::tx_context::TxContext) : 0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call::Call<0xd412a95bfe4645ddb920e3c08cfb8f7cfe9c8fe9897e957ca161cc6b85987fc5::set_worker_ptb::SetWorkerPtbParam, 0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call::Void> {
        0x601523f0fbdb81de1cb79b24d001a8aa85b9a848c337d51ab815fb476630b86c::worker_common::assert_owner(&arg0.worker, arg1);
        0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call::create<0xd412a95bfe4645ddb920e3c08cfb8f7cfe9c8fe9897e957ca161cc6b85987fc5::set_worker_ptb::SetWorkerPtbParam, 0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call::Void>(0x601523f0fbdb81de1cb79b24d001a8aa85b9a848c337d51ab815fb476630b86c::worker_common::worker_cap(&arg0.worker), arg2, true, 0xd412a95bfe4645ddb920e3c08cfb8f7cfe9c8fe9897e957ca161cc6b85987fc5::set_worker_ptb::create_param(arg3, arg4), arg5)
    }

    public fun set_supported_message_lib(arg0: &mut Executor, arg1: &0x601523f0fbdb81de1cb79b24d001a8aa85b9a848c337d51ab815fb476630b86c::worker_common::OwnerCap, arg2: address, arg3: bool) {
        0x601523f0fbdb81de1cb79b24d001a8aa85b9a848c337d51ab815fb476630b86c::worker_common::set_supported_message_lib(&mut arg0.worker, arg1, arg2, arg3);
    }

    public fun set_supported_option_types(arg0: &mut Executor, arg1: &0x601523f0fbdb81de1cb79b24d001a8aa85b9a848c337d51ab815fb476630b86c::worker_common::AdminCap, arg2: u32, arg3: vector<u8>) {
        0x601523f0fbdb81de1cb79b24d001a8aa85b9a848c337d51ab815fb476630b86c::worker_common::set_supported_option_types(&mut arg0.worker, arg1, arg2, arg3);
    }

    public fun set_worker_fee_lib(arg0: &mut Executor, arg1: &0x601523f0fbdb81de1cb79b24d001a8aa85b9a848c337d51ab815fb476630b86c::worker_common::AdminCap, arg2: address) {
        0x601523f0fbdb81de1cb79b24d001a8aa85b9a848c337d51ab815fb476630b86c::worker_common::set_worker_fee_lib(&mut arg0.worker, arg1, arg2);
    }

    public fun set_worker_info(arg0: &Executor, arg1: &0x601523f0fbdb81de1cb79b24d001a8aa85b9a848c337d51ab815fb476630b86c::worker_common::OwnerCap, arg2: &mut 0xb8d08d3a9604c51ec6ad8ee39a05e9c3fed1335df755089f1d3f0e093b9a4ec8::worker_registry::WorkerRegistry, arg3: vector<u8>) {
        0x601523f0fbdb81de1cb79b24d001a8aa85b9a848c337d51ab815fb476630b86c::worker_common::assert_owner(&arg0.worker, arg1);
        0xb8d08d3a9604c51ec6ad8ee39a05e9c3fed1335df755089f1d3f0e093b9a4ec8::worker_registry::set_worker_info(arg2, 0x601523f0fbdb81de1cb79b24d001a8aa85b9a848c337d51ab815fb476630b86c::worker_common::worker_cap(&arg0.worker), arg3);
    }

    public fun supported_option_types(arg0: &Executor, arg1: u32) : vector<u8> {
        0x601523f0fbdb81de1cb79b24d001a8aa85b9a848c337d51ab815fb476630b86c::worker_common::get_supported_option_types(&arg0.worker, arg1)
    }

    public fun worker_cap_address(arg0: &Executor) : address {
        0x601523f0fbdb81de1cb79b24d001a8aa85b9a848c337d51ab815fb476630b86c::worker_common::worker_cap_address(&arg0.worker)
    }

    public fun worker_fee_lib(arg0: &Executor) : address {
        0x601523f0fbdb81de1cb79b24d001a8aa85b9a848c337d51ab815fb476630b86c::worker_common::worker_fee_lib(&arg0.worker)
    }

    // decompiled from Move bytecode v6
}

